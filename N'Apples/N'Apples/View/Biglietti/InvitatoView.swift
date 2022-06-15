//
//  ejeje.swift
//  N'Apples
//
//  Created by Simona Ettari on 14/06/22.
//

import Foundation
import SwiftUI

struct InvitatoView: View {
    
    @State  var guestName : String = ""
    @State  var numPeople: String = ""
    @State  var email : String = ""

    var body: some View {
        
        NavigationView{
            
            GeometryReader{ geometry in
                
                
                ZStack{
                    
                    
                    Color(red: 11/255, green: 41/255, blue: 111/255)
                        .ignoresSafeArea()
                    
                    ScrollView( showsIndicators: false){
                        
                        VStack(alignment: .leading , spacing: 30 ){
                        
                           GuestNameField(eventName: $guestName)
                            NumPeopleField(eventLocation: $numPeople)
                            EmailField(availableReservation: $email)
        
                        }
                        
                        .padding()
                        
                    }
                    Button {

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
            
        }
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
