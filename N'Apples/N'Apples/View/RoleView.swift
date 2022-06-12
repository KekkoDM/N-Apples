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
    @State var showingAlertRole: Bool = false
    var body: some View {
        
        ZStack{
            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                .ignoresSafeArea()
            GeometryReader{ geometry in
                Spacer()
                
                Button {
                    
                    Task {
                        try await users.retrieveAllEmail(email: userSeacrh + " ")
                        
                        if (!users.user.isEmpty){
                            
                            presentAssignRoleView.toggle()
                            
                        } else {
                            showingAlertRole.toggle()
                        }
                        
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(.white)
                        .foregroundColor(.clear)
                        .overlay(Text("Domenico Marino")
                            .foregroundColor(.white))
                        .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.075)
                    
                    
                    
                }
                .onAppear() {
                    Task {
                        try await userModel.retrieveAll()
                    }
                    
                }
                .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.055)
                .position(x: geometry.size.width*0.3, y: geometry.size.height*0.14)
                //                  List {
                //                      ForEach(0..<roleModel.role.count) {i in
                //                          Text(roleModel.role[i].username)
                //                                 }
                //                             }
                .sheet(isPresented: $presentAssignRoleView) {
                    AssignRoleView(eventModel: $eventModel, i: $i, users: $users)
                }
                
                
            }
            
            if (showingAlertRole == true) {
                AlertRole(show: $showingAlertRole)
            }
            
        }
        
        .searchable(text: $userSeacrh)
        
        
        .navigationTitle("Assign a Role")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    
}
//    var searchResults: [String] {
//        if searchText.isEmpty {
//            return email
//        } else {
//            return email.filter { $0.contains(searchText) }
//        }
//    }


//        ZStack {
//            VStack {
//
//                HStack {
//                    TextField("Search", text: $userSeacrh)
//
//
//                    NavigationLink (destination: AssignRoleView(eventModel: $eventModel, i: $i, users: $users), isActive: $presentAssignRoleView) {
//
//                        Text("Search")
//                            .onTapGesture {
//                                Task {
//                                    try await users.retrieveAllEmail(email: userSeacrh)
//                                    print("EMAIL: " + userSeacrh)
//                                    if (!users.user.isEmpty){
//                                        print ("User Nicola: \(users.user.first!.username)")
//                                        presentAssignRoleView.toggle()
//                                    }
//
//                                }
//
//                            }
//
//                    }
//
//                }
//
//
//            }
//        }

