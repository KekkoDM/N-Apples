//
//  HomePage.swift
//  N'Apples
//
//  Created by Simona Ettari on 19/05/22.
//

import Foundation
import SwiftUI

struct HomePageView: View {
    @State var presentLogin: Bool = false
    @State var presentReservation: Bool = false
    @State var nameEvent: String = ""
    @State var presenteAlert: Bool = false

    var body: some View {
        
        NavigationView {
            
            ZStack {
                VStack (spacing: 100) {
                    Button (action: {
                        presentLogin.toggle()
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color.blue)
                                .frame(width: 300, height: 50, alignment: .center)
                            Text("Go to LoginView")
                                .foregroundColor(Color.white)
                        }
                    }
                    
                    TextField("Name Event", text: $nameEvent)
                    
                    Button (action: {
                            
                            Task {
                                
                                print("Name event prima del retrive: \(nameEvent)")
                                try await eventModel.retrieveAllName(name: nameEvent)
                                
                                if (nameEvent != eventModel.event.first?.name) {
                                    eventModel.event.removeAll()
                                    print("ModelCount in if \(eventModel.event.count)")
                                }
                                
                                print("Name event: \(nameEvent)")
                                print("Model count \(eventModel.event.count)")
                                
                                if (!eventModel.event.isEmpty) {
                                    print ("Non Vuoto")
                                    presentReservation.toggle()
                                } else {
                                    presenteAlert.toggle()
                                    print ("Vuoto")
                                }
                            }
                            
                        
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color.blue)
                                .frame(width: 300, height: 50, alignment: .center)
                            Text("Search Event")
                                .foregroundColor(Color.white)
                        }
                    }
                  
                }
                if (presentReservation == true) {
                    ReservationView()
                }
                
                if (presenteAlert == true) {
                    AlertError(show: $presenteAlert)
                }
            }
            .navigationTitle("My Events")
        }
    }
    
}
