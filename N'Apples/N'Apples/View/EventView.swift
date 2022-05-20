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
    @State var userModel : UserModel = UserModel()
    @State var presentUpdateView: Bool = false
    @State var eventModel: EventModel = EventModel()
    @State var roleModel: RoleModel = RoleModel()
    @State var role: Role = Role()
    @State var image:UIImage = UIImage()
    
    var body: some View {
        
            ZStack {
                VStack (spacing: 70) {
                    NavigationLink (destination: UpdateView(userModel: $userModel), isActive: $presentUpdateView) {
                        Text("My Self")
                            .onTapGesture {
                                presentUpdateView.toggle()
                            }
                    }
                    
                    VStack {
                        ForEach(0 ..< eventModel.event.count, id: \.self) { i in
                            Text(eventModel.event[i].name)
                                .onAppear(){
                                    print("ueue \(eventModel.event.count)")
                                }
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
            } .onAppear() {
                Task {
                    try await roleModel.retrieveAllUsername(username: usernamesaved)
//                    print("Conta" + "\(roleModel.role.count)")

                    for i in 0 ..< roleModel.role.count {
                        try await eventModel.retrieveAllId(id: roleModel.role[i].idEvent)
                        print(roleModel.role.count)
                        print(i)
                    }
                   
                    print(usernamesaved)
                    
//                    let data = try? Data(contentsOf: (eventModel.event.first?.poster.fileURL!)!)
//                    image = UIImage(data: data!)!
                }
            }
            .navigationTitle("My Event")
            .padding()
    }
}
