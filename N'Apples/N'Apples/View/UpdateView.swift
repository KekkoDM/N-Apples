//
//  LoginView.swift
//  BackSpinUI
//
//  Created by Nicola D'Abrosca on 24/03/22.
//

import Foundation
import SwiftUI

struct UpdateView: View {
    
    @State var userModel : UserModel
    @State var password = ""
    @State var showingAlertField: Bool = false
    @State var contentView: Bool = false
    @State var showLogin: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Button (action: {
                    userModel.reset()
                    print("looooog\(userModel.user)")
                    showLogin.toggle()
                    
                    
                }) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.blue)
                            .frame(width: 300, height: 50, alignment: .center)
                        Text("Logout")
                            .foregroundColor(Color.white)
                           
                    }
                }
                
                
//                RoundedRectangle(cornerRadius: 25)
//                    .foregroundColor(Color.white)
//                    .frame(width: 1000, height: 1000, alignment: .center)
//
//                VStack () {
//
//                    HStack {
//
//                        Text ("Change Password")
//                            .foregroundColor(.black)
//                            .font(.title)
//                            .padding(.trailing)
//                    }
//                    .padding(.bottom,290)
//
//                    HStack {
//                        Text("Username: ")
//                            .foregroundColor(.blue)
//                        Text(userModel.user.first?.username ?? "")
//                            .foregroundColor(.black)
//                    }.padding(.bottom, 8)
//
//                    HStack {
//                        Text("Password: ")
//                            .foregroundColor(.blue)
//                        Text(userModel.user.first?.password ?? "")
//                            .foregroundColor(.black)
//
//                    }.padding(.bottom, 16)
//
//                    SecureField("New password",text: $password)
//                        .foregroundColor(.black)
//                        .padding()
//                        .frame(width: 300, height: 35, alignment: .center)
//                        .padding(12)
//                        .overlay (
//                            RoundedRectangle(cornerRadius: 14)
//                                .stroke(Color.blue, lineWidth: 1)
//                                .frame(width: 300, height: 35, alignment: .center)
//                        )
//                        .padding(.bottom, 250)
//
//                    Button (action: {
//                        if password == "" {
//                            self.showingAlertField = true
//                        } else {
//                            Task {
//                                try await userModel.updatePw(user: userModel.user.first!, password: password)
//                            }
//                        }
//                    }) {
//                        ZStack{
//                            RoundedRectangle(cornerRadius: 25)
//                                .foregroundColor(Color.blue)
//                                .frame(width: 300, height: 50, alignment: .center)
//                            Text( "Update")
//                                .foregroundColor(Color.white)
//                        }
//                    }.padding(.bottom, 10)
//
//                }
//                Spacer()
                
                if showLogin == true {
                    LoginView()
                }
            }.navigationBarHidden(true)
        }
    }
    
}
