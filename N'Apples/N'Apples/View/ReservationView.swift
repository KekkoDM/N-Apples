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
                        GuestSurNameField(eventSurName: $surname)
                        EmailField(availableReservation: $email)
                        NameListField(eventNameList: $nameList)
                        NumPeopleField(eventLocation: $numFriends)
                        
                    }.padding()
                    VStack(alignment: .center) {
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
                    }
                    
                }
        
                Button {
                    Task{
                        try await reservationModel.insert(event: event.id, id: qrNumber.uuidString, name: name, surname: surname, email: email, nameList: nameList, numFriends: Int(numFriends) ?? 0)
                        showqr = true
                    }
                } label: {
                Rectangle()
                    .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.075)
//                    .frame(width: 200, height: 50, alignment: .center)
                    .cornerRadius(10)
                    .overlay(Text("Add new Guest")
                            .foregroundColor(.white)
                                .font(.system(size: 20))
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
        TextField("Guest name", text: $eventName)
            .foregroundColor(.white).font(.system(size: 21))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white, lineWidth: 3)
            )
    }
}

struct GuestSurNameField : View {
    @Binding var eventSurName : String
    var body: some View {
        TextField("Guest surname", text: $eventSurName)
            .foregroundColor(.white).font(.system(size: 21))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white, lineWidth: 3)
            )
    }
}

struct NameListField: View {
    @Binding var eventNameList : String
    var body: some View {
        TextField("Name list ", text: $eventNameList)
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
