//
//  CreaEvento.swift
//  N'Apples
//
//  Created by Simona Ettari on 10/05/22.
//

import Foundation
import SwiftUI


struct ReservationView: View {
    
    @State var name: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    @State var nameList: String = ""
    @State var numFriends: String = ""
    @State var qrNumber = UUID()
    @State var show = showSaved
    @State var showqr:Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    ZStack {
                        VStack {
                            Text("My Reservation")
                            TextField("Name", text: $name)
                            TextField("Surname", text: $surname)
                            TextField("Email", text: $email)
                            TextField("Name List", text: $nameList)
                            TextField("Number of friends", text: $numFriends)
                        }
                    }
                    
                    
                    let qrImage = generateQRCode(from: "\(qrNumber)")
                    let image = Image(uiImage: qrImage)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    if(showqr){
                    image
                        .onLongPressGesture {

                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrImage)
                            show.toggle()
                            
                        }
                    }
                    Button(action: {
                        Task{
                            try await reservationModel.insert(id: qrNumber.uuidString, name: name, surname: surname, email: email, nameList: nameList, numFriends: Int(numFriends) ?? 0)
                            showqr = true
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.blue)
                                .frame(width: 200, height: 100, alignment: .center)
                            Text("Confirm")
                                .foregroundColor(.white)
                        }.padding(.bottom, 40)
                    })
                    Button(action: {
                        Task{
                            try await reservationModel.retrieveAllId(id:qrNumber.uuidString)
                            try await reservationModel.updatepzzot(at: 0, id: qrNumber.uuidString)

                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.blue)
                                .frame(width: 200, height: 100, alignment: .center)
                            Text("Update")
                                .foregroundColor(.white)
                        }.padding(.bottom, 40)
                    })
                }
            }
            
            if(show) {
                Alert(show: $show)
            }
            
        }
        
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}



