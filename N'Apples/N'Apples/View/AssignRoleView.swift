//
//  AssignRoleView.swift
//  N'Apples
//
//  Created by Simona Ettari on 24/05/22.
//

import Foundation
import SwiftUI

struct AssignRoleView: View {
    @Binding var eventModel: EventModel
    @Binding var i: Int
    @Binding var users: UserModel
    @State var roleModel: RoleModel = RoleModel()
    @State var pushNotification: CloudkitPushNotificationViewModel = CloudkitPushNotificationViewModel()
    
    
    
    @Environment(\.dismiss)
    var dismiss
    var roles = ["Collaborator","PR", "Box-Office"]
    @State var selectedRole: String = "Collaborator"
    @State private var showPopUp = false
    //    @State var shownInfo = false
    //    @State var shown = false
    @State  var permission: Int = 0
    
    
    var body: some View {
        
        //        ZStack {Color.white
        //            VStack {
        //                Text(users.user.first!.username)
        //
        //                Button (action: {
        //                    Task {
        //                        pushNotification.subscribe(textType: "Role", userName: users.user.first!.username)
        //                        print("PORCHE NOTIFICHE\(users.user.first!.username)")
        //                        try await roleModel.insert(username: users.user.first!.username, permission: [1, 0, 0], idEvent: eventModel.event[i].id)
        //                        pushNotification.unsubscribe(userName: users.user.first!.username)
        //                    }
        //                }, label: {
        //                    Text("Guardio")
        //                })
        //
        //                Button (action: {
        //                    Task {
        //                        pushNotification.subscribe(textType: "Role", userName: users.user.first!.username)
        //                        try await roleModel.insert(username: users.user.first!.username, permission: [0, 1, 0], idEvent: eventModel.event[i].id)
        //                        pushNotification.unsubscribe(userName: users.user.first!.username)
        //                    }
        //                }, label: {
        //                    Text("Collabarotare")
        //                })
        //
        //                Button (action: {
        //                    Task {
        //                        pushNotification.subscribe(textType: "Role", userName: users.user.first!.username)
        //                        try await roleModel.insert(username: users.user.first!.username, permission: [0, 0, 1], idEvent: eventModel.event[i].id)
        //                        pushNotification.unsubscribe(userName: users.user.first!.username)
        //                    }
        //                }, label: {
        //                    Text("Organizzatore")
        //                })
        //            }
        //        }
        
        
        ZStack{
            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                .ignoresSafeArea()
            
            
            GeometryReader{ geometry in
                
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .position(x: geometry.size.width*0.1, y: geometry.size.height*0.04)
                
                Button {
                    Task {
                        pushNotification.subscribe(textType: "Role", userName: users.user.first!.username)
                        if selectedRole == "Collaborator"{
                            permission = 0  }
                        else if selectedRole == "PR"{
                            permission = 1
                        }else if selectedRole == "Box-Office"{
                            permission = 2
                        }
//                        try await roleModel.insert(username: users.user.first!.username, permission: permission, idEvent: eventModel.event[i].id)
                        try await roleModel.update(usename: users.user.first!.username, idEvent: eventModel.event[i].id, permission: permission)
                        pushNotification.unsubscribe(userName: users.user.first!.username)
                        dismiss()
                    }
                } label: {
                    Text( "Add")
                }
                
                .position(x: geometry.size.width*0.92, y: geometry.size.height*0.04)
                
                
                
                VStack(alignment: .leading, spacing: 50) {
                    Text("\(users.user.first!.username)")
                        .font(.title)
                        .bold()
                    
                    
                    Text("E-mail: \(users.user.first!.email)")
                        .font(.headline)
                    
                }
                .foregroundColor(.white)
                .position(x: geometry.size.width*0.37, y: geometry.size.height*0.25)
                
                
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Text("Roles")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                            .padding(2)
                        Button(action: {
                            self.showPopUp = true
                        }, label: {
                            Image(systemName: "info.circle")
                        })
                        
                    }
                    
                    Picker(
                        selection: $selectedRole,
                        label:
                            HStack{
                                Text("Assegna ruolo")
                                Text(selectedRole)
                                
                            }
                        
                        , content: {
                            ForEach(roles, id: \.self) { option in
                                Text(option)
                                    .tag(option)
                            }
                        })
                    .pickerStyle(MenuPickerStyle())
                    
                }
                .position(x: geometry.size.width*0.16, y: geometry.size.height*0.5)
                
                if (showPopUp){
                    ZStack {
                        Color.white
                        VStack {
                            
                            Text("What can Roles do?")
                                .font(.system(size: 18))
                                .bold()
                                .position(x: geometry.size.width*0.19, y: geometry.size.height*0.01)
                                .foregroundColor(.black)
                            
                            
                            VStack(alignment:.leading, spacing: 5){
                                
                                Text("Collaborator")
                                    .font(.headline)
                                    .bold()
                                
                                Text("They have access to the same functions as you.")
                                    .font(.body)
                                
                                Text("Promoter")
                                    .font(.headline)
                                
                                
                                    .bold()
                                Text("They can only manage their lists.")
                                    .font(.body)
                                
                                
                                Text("Box-Office")
                                    .font(.headline)
                                
                                
                                    .bold()
                                Text("They can access to the lists and they scan partcipants’ QR Codes. ")
                                    .font(.body)
                                
                                
                            }
                            .frame(width: geometry.size.width*0.45, height: geometry.size.height*0.3)
                            .position(x: geometry.size.width*0.22, y: geometry.size.height*0.01)
                            .foregroundColor(.black)
                            
                            Button(action: {
                                self.showPopUp = false
                            }, label: {
                                Text("Close")
                            })
                        }.padding()
                        
                        
                    }.cornerRadius(10).shadow(radius: 10)
                        .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.4)
                        .position(x: geometry.size.width*0.52, y: geometry.size.height*0.67)
                }
            }
            
        }.onTapGesture {
            self.showPopUp = false
        }
    }
}
