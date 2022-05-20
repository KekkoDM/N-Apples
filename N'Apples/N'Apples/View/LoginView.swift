//
//  LoginView.swift
//  N'Apples
//
//  Created by Simona Ettari on 20/05/22.
//

import Foundation
import SwiftUI

var usernamesaved = ""

struct LoginView: View {
    
    @State var username = ""
    @State var mail = ""
    @State var password = ""
    @State var presentEventView: Bool = false
    @State var presentAlert: Bool = false
    @State var userModel : UserModel = UserModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 20) {
//                    NavigationLink (destination: UpdateView(userModel: $userModel), isActive: $presentUpdateView) {
//                        Text("My Self")
//                            .onTapGesture {
//                                Task {
//                                    try await userModel.retrieveAllUsernamePassword(username: username, password: password)
//                                    presentUpdateView.toggle()
//                                }
//                            }
//                    }
                    VStack {
                        
                        TextField("Username", text: $username)
                            .padding(.leading,50)
                        
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.black)
                            .frame(width: 300, height: 0.5, alignment: .leading)
                            .padding(.trailing, 80)
                        
                        TextField("Mail", text: $mail)
                            .padding(.leading,50)
                        
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.black)
                            .frame(width: 300, height: 0.5, alignment: .leading)
                            .padding(.trailing, 80)
                        
                        SecureField("Password", text: $password)
                            .padding(.leading,50)
                        
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.black)
                            .frame(width: 300, height: 0.5, alignment: .leading)
                            .padding(.trailing, 80)
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        if self.username.isEmpty {
                            SignUpWithAppleView(username: $username, mail:$mail, password: $password)
                                .frame(width: 200, height: 50)
                        }
                        else {
                            Text("Welcome\n\(self.username)")
                                .font(.headline)
                        }
                    }
                    
                    VStack {
                        HStack (spacing: 15) {
                            
                            NavigationLink (destination: EventView(), isActive: $presentEventView) {
                                Text("Login")
                                    .onTapGesture {
                                        Task {
                                            try await userModel.retrieveAllUsernamePassword(username: username, password: password)
                                            usernamesaved = username
                                            presentEventView.toggle()
                                        }
                                    }
                            }
                            
                            NavigationLink (destination: self, isActive: $presentAlert) {
                                Text("Sign Up")
                                    .onTapGesture {
                                        Task {
                                            try await userModel.insert(username: username, password: password)
                                            presentAlert.toggle()
                                            
                                        }
                                    }
                            }
                        }
                    }
                }
                if (presentAlert == true) {
                    Alert(show: $presentAlert)
                }
            }
            .navigationTitle("Welcome")
            .padding()
        }
        
    }
    
}
