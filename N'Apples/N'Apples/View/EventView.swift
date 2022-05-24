//
//  EventView.swift
//  N'Apples
//
//  Created by Simona Ettari on 20/05/22.
//

import Foundation
import SwiftUI

struct EventView: View {
    
    @State var presentCreationView: Bool = false
    @State var presentUpdateView: Bool = false
    @State var presentRecapEventView: Bool = false
    @State var eventModel: EventModel
    @State var roleModel: RoleModel
    @State var role: Role = Role()
    @State var image: UIImage = UIImage()
    @State var intero: Int = 0
    
    var body: some View {
        
            ZStack {
                VStack (spacing: 70) {
                    NavigationLink (destination: UpdateView(userModel: userModel), isActive: $presentUpdateView) {
                        Text("My Self")
                            .onTapGesture {
                                presentUpdateView.toggle()
                            }
                    }
                    
                    VStack {
                        ForEach(0 ..< eventModel.event.count, id: \.self) { i in
                            NavigationLink (destination: RecapEventView(eventModel: $eventModel, i: $intero), isActive: $presentRecapEventView) {
                                Text(eventModel.event[i].name)
                                    .onTapGesture {
                                        intero = i
                                        presentRecapEventView.toggle()
                                    }
                            }
//                            Text(eventModel.event[i].name)
//                                .onAppear(){
//                                    print("ueue \(eventModel.event.count)")
//                                }
                        }
                    }
                    
                    
                    
                    VStack (spacing: 20) {
                        NavigationLink (destination: CreationView(), isActive: $presentCreationView) {
                            Text("Create Event")
                                .onTapGesture {
                                    presentCreationView.toggle()
                                }
                        }
                    }
                }
            }

            .navigationTitle("My Event")
            .padding()
    }
}
