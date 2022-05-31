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
    
    var body: some View {
        ZStack {
            VStack {
                Text(users.user.first!.username)
                
                Button (action: {
                    Task {
                        pushNotification.subscribe(textType: "Role", userName: users.user.first!.username)
                        print("PORCHE NOTIFICHE\(users.user.first!.username)")
                        try await roleModel.insert(username: users.user.first!.username, permission: [1, 0, 0], idEvent: eventModel.event[i].id)
                        pushNotification.unsubscribe(userName: users.user.first!.username)
                    }
                }, label: {
                    Text("Guardio")
                })
                
                Button (action: {
                    Task {
                        pushNotification.subscribe(textType: "Role", userName: users.user.first!.username)
                        try await roleModel.insert(username: users.user.first!.username, permission: [0, 1, 0], idEvent: eventModel.event[i].id)
                        pushNotification.unsubscribe(userName: users.user.first!.username)
                    }
                }, label: {
                    Text("Collabarotare")
                })
                
                Button (action: {
                    Task {
                        pushNotification.subscribe(textType: "Role", userName: users.user.first!.username)
                        try await roleModel.insert(username: users.user.first!.username, permission: [0, 0, 1], idEvent: eventModel.event[i].id)
                        pushNotification.unsubscribe(userName: users.user.first!.username)
                    }
                }, label: {
                    Text("Organizzatore")
                })
            }
        }
    }
}
