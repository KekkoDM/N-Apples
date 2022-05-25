//
//  RoleView.swift
//  N'Apples
//
//  Created by Simona Ettari on 24/05/22.
//

import Foundation
import SwiftUI

struct RoleView: View {
    @Binding var i: Int
    @Binding var eventModel: EventModel
    @State var users: UserModel = UserModel()
    @State var presentAssignRoleView: Bool = false
    @State var userSeacrh: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    TextField("Search", text: $userSeacrh)
                    
                    
                    NavigationLink (destination: AssignRoleView(eventModel: $eventModel, i: $i, users: $users), isActive: $presentAssignRoleView) {
                        
                        Text("Search")
                            .onTapGesture {
                                Task {
                                    try await users.retrieveAllEmail(email: userSeacrh)
                                    print("EMAIL: " + userSeacrh)
                                    if (!users.user.isEmpty){
                                        print ("User Nicola: \(users.user.first!.username)")
                                        presentAssignRoleView.toggle()
                                    }
                                    
                                }
                                
                            }
                        
                    }
                    
                }
                
                
            }
        }
    }
}

