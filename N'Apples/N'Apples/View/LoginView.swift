//
//  LoginView.swift
//  N'Apples
//
//  Created by Simona Ettari on 20/05/22.
//

import Foundation
import SwiftUI

func retrieveMyEvents() async throws -> Bool{
    if(!(userModel.user.isEmpty)){

        try await roleModel.retrieveAllUsername(username: userModel.user.first!.username)
        
        for i in 0 ..< roleModel.role.count {
            try await eventModel.retrieveAllId(id: roleModel.role[i].idEvent)
        }
        return true
    }
    else{
        return false
    }
    
}

struct LoginView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @State var username = ""
    @State var mail = ""
    @State var password = ""
    @State var presentEventView: Bool = false
    @State var presentAlert: Bool = false
    @State var signInApple: Bool = false
//    @State var usernameApple = ""
    @State var idApple = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 20) {

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
                            SignUpWithAppleView(username: $username, mail: $mail, id: $idApple, signInApple: $signInApple)
                                .frame(width: 200, height: 50)
                        }
                        else {
                            Text("Welcome\n\(self.username)")
                                .font(.headline)
                                .onAppear() {
                                    if (signInApple == true) {
                                        print("Id apple: \(idApple)")
                                        Task {
                                            try await userModel.retrieveAllId(id: idApple)
                                            if (userModel.user.isEmpty) {
                                                try await userModel.insertApple(username: username, email: mail, id: idApple)
                                                userSettings.id = idApple
                                            } else {
                                                username = userModel.user.first!.username
                                                presentEventView.toggle()
                                            }
                                        }
                                    }
                                    
                                }
                        }
                    }
                    
                    VStack {
                        
                        HStack (spacing: 15) {
                            
                            NavigationLink (destination: EventView (eventModel: eventModel, roleModel: roleModel), isActive: $presentEventView) {
                                Text("Login")
                                    .onTapGesture {
                                        Task {
//                                            try await userModel.retrieveAllUsernamePassword(username: username,password: password)
                                            try await userModel.retrieveAllName(username: username)

                                            if(!userModel.user.isEmpty){
                                                presentEventView.toggle()
                                            }
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
        } .onAppear() {
            Task {
                try await userModel.retrieveAllId(id: userSettings.id)
                username = userModel.user.first?.username ?? ""
                try await retrieveMyEvents()
            }
        }
        
    }
  
    
    
    
}
