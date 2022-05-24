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
    
    var body: some View {
        ZStack {
            VStack {
                Text(users.user.first!.username)
                
                Button (action: {
                    Task {
                        try await roleModel.insert(username: users.user.first!.username, permission: [1], idEvent: eventModel.event[i].id)
                    }
                }, label: {
                    Text("Choice role")
                })
            }
        }
    }
}
