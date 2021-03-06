//
//  LoginView.swift
//  N'Apples
//
//  Created by Simona Ettari on 20/05/22.
//

import Foundation
import SwiftUI

func retrieveMyEvents() async throws -> Bool {
    
    if(!(userModel.user.isEmpty)){
        roleModel.reset()
        eventModel.reset()
        
        try await roleModel.retrieveAllUsername(username: userModel.user.first!.username)
        for i in 0 ..< roleModel.role.count {
            try await eventModel.retrieveAllId(id: roleModel.role[i].idEvent)
        }
        if(roleModel.role.count == 0) {
            return false
        }
        print("RUOLI: \(roleModel.role.count)")
        print("EVENT: \(eventModel.event.count)")
        return true
    }
    else {
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
    @State var idApple = ""
    @State var indici: [Int] = []
    var body: some View {
        
        ZStack {
            GeometryReader{
                geometry in
                
                
                Rectangle()
                    .foregroundColor(Color(red: 0.91, green: 0.93, blue: 1))
                    .frame(width: geometry.size.width * 1, height: geometry.size.width * 0.7)
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.06)
                
                
                Image(uiImage: UIImage(named: "doodle3")!)
                
                    .position(x: geometry.size.width * 0.83, y: geometry.size.height * 0.0)
                
                VStack{
                Text("Welcome to\n").font(.system(size: 35).weight(.semibold))
                                    .foregroundColor(Color(red: 11/255, green: 41/255, blue: 111/255)) + Text("InNight").font(.system(size: 45).weight(.bold))
                                    .foregroundColor(.orange)
                }.frame(width: geometry.size.width * 1, height: geometry.size.width * 0.56, alignment: .center).padding(.top, 35).multilineTextAlignment(.center)

                
//                    .frame(width: geometry.size.width * 1, height: geometry.size.width * 0.56, alignment: .center)
//                    .padding(.top, 25)
//                    .multilineTextAlignment(.center)
//                    .font(.system(size: 35).weight(.semibold))
//                    .foregroundColor(.black)
//                    .frame(width: geometry.size.width * 1, height: geometry.size.width * 0.56, alignment: .center)
//                    .padding(.top, 25)
//                    .multilineTextAlignment(.center)
//                    .font(.system(size: 35).weight(.semibold))
//                    .foregroundColor(.black)
                
                VStack{
                    
                    Image(uiImage: UIImage(named: "party")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.7)
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.46)
                    
                    SignUpWithAppleView(username: $username, mail: $mail, id: $idApple, signInApple: $signInApple)
                        .frame(width: geometry.size.width * 0.67, height: geometry.size.width * 0.15, alignment: .center)
                        .onChange(of: signInApple, perform: {_ in
                            
                            Task {
                                let usrDef = UserDefaults.standard
                                usrDef.set(username, forKey: "Username")
                                
                                try await userModel.retrieveAllId(id: idApple)
                                if (userModel.user.isEmpty) {
                                    try await userModel.insertApple(username: username, email: mail, id: idApple)
                                    userSettings.id = idApple
                                   
                                    presentEventView.toggle()
                                } else {
                                    
                                    userSettings.id = idApple
                                    
                                    username = userModel.user.first!.username
                                    presentEventView.toggle()
                                }
                            }
                        })
                    
                    
                }
                
                
            }
            
            
            
            //                VStack (spacing: 20) {
            //
            //                    VStack {
            //
            //                        TextField("Username", text: $username)
            //                            .padding(.leading,50)
            //
            //                        RoundedRectangle(cornerRadius: 25)
            //                            .foregroundColor(.black)
            //                            .frame(width: 300, height: 0.5, alignment: .leading)
            //                            .padding(.trailing, 80)
            //
            //                        TextField("Mail", text: $mail)
            //                            .padding(.leading,50)
            //
            //                        RoundedRectangle(cornerRadius: 25)
            //                            .foregroundColor(.black)
            //                            .frame(width: 300, height: 0.5, alignment: .leading)
            //                            .padding(.trailing, 80)
            //
            //                        SecureField("Password", text: $password)
            //                            .padding(.leading,50)
            //
            //                        RoundedRectangle(cornerRadius: 25)
            //                            .foregroundColor(.black)
            //                            .frame(width: 300, height: 0.5, alignment: .leading)
            //                            .padding(.trailing, 80)
            //                    }
            //
            //                    Spacer()
            //
            //                    VStack {
            //
            //                        if self.username.isEmpty {
            //                            SignUpWithAppleView(username: $username, mail: $mail, id: $idApple, signInApple: $signInApple)
            //                                .frame(width: 200, height: 50)
            //                        }
            //                        else {
            //                            Text("Welcome\n\(self.username)")
            //                                .font(.headline)
            //                                .onAppear() {
            //                                    if (signInApple == true) {
            //                                        print("Id apple: \(idApple)")
            //                                        Task {
            //                                            try await userModel.retrieveAllId(id: idApple)
            //                                            if (userModel.user.isEmpty) {
            //                                                try await userModel.insertApple(username: username, email: mail, id: idApple)
            //                                                userSettings.id = idApple
            //                                            } else {
            //                                                username = userModel.user.first!.username
            //                                                presentEventView.toggle()
            //                                            }
            //                                        }
            //                                    }
            //
            //                                }
            //                        }
            //                    }
            //
            //                    VStack {
            //
            //
            //
            //                        HStack (spacing: 15) {
            //
            //                            NavigationLink (destination: EventView (eventModel: eventModel, roleModel: roleModel), isActive: $presentEventView) {
            //                                Text("Login")
            //                                    .onTapGesture {
            //                                        Task {
            //                                            try await userModel.retrieveAllName(username: username)
            //
            //                                            if(!userModel.user.isEmpty){
            //                                                presentEventView.toggle()
            //                                            }
            //                                        }
            //                                    }
            //                            }
            //
            //                            NavigationLink (destination: self, isActive: $presentAlert) {
            //                                Text("Sign Up")
            //                                    .onTapGesture {
            //                                        Task {
            //                                            try await userModel.insert(username: username, password: password, email: mail)
            //                                            presentAlert.toggle()
            //                                        }
            //                                    }
            //                            }
            //                        }
            //                    }
            //                }
            //                if (presentAlert == true) {
            //                    Alert(show: $presentAlert)
            //                }
            //            }
            //            .navigationTitle("Welcome")
            //            .padding()
            
            .onAppear() {
                Task {
                    try await userModel.retrieveAllId(id: userSettings.id)
                    username = userModel.user.first?.username ?? ""
                    
                    if !userModel.user.isEmpty{
                        presentEventView.toggle()
                       
                    }
                   
                }
            }
            if (presentEventView){
//                GifFile(eventModel: eventModel, roleModel: roleModel, indici: $indici)
                EventView (eventModel: eventModel, roleModel: roleModel)
                
            }
        }.background(Color(red: 0.91, green: 0.93, blue: 1))
        
    }
    
    
    
}
