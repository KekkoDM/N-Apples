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
    @State var show = false
    @State var showqr:Bool = false
    @State var event: Event
    
    var body: some View {
        

            GeometryReader{ geometry in

            ZStack {
                Color(red: 11/255, green: 41/255, blue: 111/255)
                    .ignoresSafeArea()
                ScrollView( showsIndicators: false){
                    
                    VStack(alignment: .leading , spacing: 30 ){
                        GuestNameField(eventName: $name)
                        GuestNameField(eventName: $surname)
                        EmailField(availableReservation: $email)
                        GuestNameField(eventName: $nameList)

                         NumPeopleField(eventLocation: $numFriends)
                        
                    
                    let qrImage = generateQRCode(from: "\(qrNumber)")
                    let image = Image(uiImage: qrImage)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    if(showqr){
                        image
                            .onLongPressGesture {
                                show.toggle()
                                let imageSaver = ImageSaver()
                                imageSaver.writeToPhotoAlbum(image: qrImage)
                               
                                
                            }
                    }
                 
                       
                       
                    }.padding()
                    
                }
        
                Button {
                    Task{
                        try await reservationModel.insert(event: event.id, id: qrNumber.uuidString, name: name, surname: surname, email: email, nameList: nameList, numFriends: Int(numFriends) ?? 0)
                        showqr = true
                    }
                } label: {
                Rectangle()
                    .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.075)
                    .cornerRadius(10)
                    .overlay(Text("Add new Guest")
                                .font(.system(size: 25))
                                .bold()
                    .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)))
                            
            }
                .position(x: geometry.size.width*0.5, y: geometry.size.height*0.95)
                }
            .navigationTitle("New Guest")
            .navigationBarTitleDisplayMode(.inline)

            }
         
        if(show) {
            Alert(show: $show)
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




struct GuestNameField : View {
    @Binding var eventName : String
    var body: some View {
        TextField("Guest Name", text: $eventName)
            .foregroundColor(.white).font(.system(size: 21))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white, lineWidth: 3)
            )
    }
}

struct NumPeopleField: View {
    @Binding var eventLocation : String
    var body: some View {
        TextField("Number of people invited ", text: $eventLocation)
            .foregroundColor(.white).font(.system(size: 21))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white, lineWidth: 3)
            )
    }
}

struct EmailField: View {
    @Binding var availableReservation : String
    var body: some View {
        TextField("Guest email", text: $availableReservation)
            .foregroundColor(.white).font(.system(size: 21))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white, lineWidth: 3)
            )
    }
}
