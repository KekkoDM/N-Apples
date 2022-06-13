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
        
        
//        GeometryReader{ geometry in
//        ZStack {
//            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
//                .ignoresSafeArea()
        ZStack {
            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                .ignoresSafeArea()
                VStack{
                    
                    
                    VStack(spacing: 25.0){
                        
                        Text("Write the email of your collaborators")
                        .font(.title2)
                        
                        TextField("", text: $userSeacrh)
                            .placeholder(when: userSeacrh.isEmpty){
                                Text("Write email").foregroundColor(.init(red: 0.72, green: 0.75, blue: 0.79, opacity: 1.00))
                            }
                            .padding(7)
                            .padding(.horizontal, 25)
                            .foregroundColor(.init(red: 0.72, green: 0.75, blue: 0.79, opacity: 1.00))
                            .background(Color(red: 0.24, green: 0.30, blue: 0.59).opacity(0.9))
                        
                        
                            .cornerRadius(20)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.init(red: 0.72, green: 0.75, blue: 0.79, opacity: 1.00))
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 8)
                                })

                            
                    }
                    .padding()
             
                    
                    
                    Button {
                        
                        Task {
                            try await users.retrieveAllEmail(email: userSeacrh + " ")
                            
                            if (!users.user.isEmpty) {
                                
                                presentAssignRoleView.toggle()
                                
                            } else {
                                showingAlertRole.toggle()
                            }
                            
                        }
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 7)
                        
                            .foregroundColor(.orange)
                            .overlay(Text("Search")
                                .foregroundColor(.white))
                            .frame(width: 200, height: 50, alignment: .center)
                           
//                            .padding(.leading, 170)
                            .padding()
                        
                        
                    }

                    .onAppear() {
                        Task {
                            try await userModel.retrieveAll()
                        }
                    }
               
            
                    .navigationTitle("Assign a Role")
                    .navigationBarTitleDisplayMode(.inline)
                        
                    
                }.background(Color(red: 0.19, green: 0.28, blue: 0.51)
                    .ignoresSafeArea())
                .cornerRadius(20)
                .padding()
        }
//                .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.055)
//                .position(x: geometry.size.width*0.3, y: geometry.size.height*0.14)
                //                  List {
                //                      ForEach(0..<roleModel.role.count) {i in
                //                          Text(roleModel.role[i].username)
                //                                 }
                //                             }
                .sheet(isPresented: $presentAssignRoleView) {
                    AssignRoleView(eventModel: $eventModel, i: $i, users: $users)
                }
                
                
//            }
            
            if (showingAlertRole == true) {
                AlertRole(show: $showingAlertRole)
            }
            
//        }
        
        //        .searchable(text: $userSeacrh)
        
        
        
        
    }
    
   
    
    
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
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

