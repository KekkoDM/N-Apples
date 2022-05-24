//
//  ContentView.swift
//  N'Apples
//
//  Created by Simona Ettari on 07/05/22.
//

import SwiftUI

var reservationModel : ReservationModel = ReservationModel()
var userModel = UserModel()
var eventModel = EventModel()
var roleModel = RoleModel()


struct ContentView: View {
    
    @State var altezza: CGFloat = 40
    @State var larghezza: CGFloat = 150
    @State var username = ""
    @State var mail = ""
    @State var password = ""
    @State var showingAlert: Bool = false
    @State var showingAlertRegister: Bool = false
    @State var showingAlertField: Bool = false
    @State var createEvents: Bool = false
    @State var reservation: Bool = false
    @State var updateView: Bool = false
    @State var cameraQr: Bool = false
    @State var userModel : UserModel = UserModel()
    
    @State var testdownload: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                VStack {
                    Text("N'Apples")
                        .foregroundColor(.black)
                        .font(.title)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    TextField("Username", text: $username)
                        .padding(.leading,50)
//                    TextField("Surname", text: $surname)
//                        .padding(.leading,50)
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
                    
                    Spacer()
                    VStack{
                      
                        if self.username.isEmpty {
//                            SignUpWithAppleView(username: $username, mail: $mail, id: $password)
//                                .frame(width: 200, height: 50)
                        }
                        else{
                            Text("Welcome\n\(self.username)")
                                .font(.headline)
                                .onAppear{Task {
//                                    try await userModel.insert(username: username, password: surname)
                                    //                            try await UserModel.retrieveAllId(id: "456")
//                                    print(userModel.user)
                                }}
                        }
                        
                    }
                }
                VStack{
                    VStack {
                        HStack (spacing: 15){
                            Button (action: {
                                Task {
                                    
                                     try await userModel.retrieveAllUsernamePassword(username: username, password: password)
                                    
//                                    try decryptStringToCodableOject(String.self, from: userModel.user.first?.password ?? "", usingKey: key)
                                    updateView.toggle()
                                }
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(.blue)
                                        .frame(width: larghezza, height: altezza, alignment: .center)
                                    Text("Login")
                                        .foregroundColor(.white)
                                }
                            }.padding(.bottom, 40)
                            
                            Button (action: {
                                Task {
                                    try await userModel.insert(username: username, password: password)
                                    //                            try await UserModel.retrieveAllId(id: "456")
                                    print(userModel.user)
                                }
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(.blue)
                                        .frame(width: larghezza, height: altezza, alignment: .center)
                                    Text("Sing Up")
                                        .foregroundColor(.white)
                                }
                            }.padding(.bottom, 40)
                            
                            
                        }
                    }
                    HStack (spacing: 15) {
                        Button(action: {
                            createEvents = true
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(.blue)
                                    .frame(width: larghezza, height: altezza, alignment: .center)
                                Text("Create Events")
                                    .foregroundColor(.white)
                            }
                        })
                        Button(action: {
                            reservation = true
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(.blue)
                                    .frame(width: larghezza, height: altezza, alignment: .center)
                                Text("Reservation ")
                                    .foregroundColor(.white)
                            }
                        })
                    }
                    HStack{
                        Button(action: {
                            cameraQr = true
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(.blue)
                                    .frame(width: larghezza, height: altezza, alignment: .center)
                                Text("Camera Qr")
                                    .foregroundColor(.white)
                            }
                        })
                        
                        Button(action: {
                            testdownload = true
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(.blue)
                                    .frame(width: larghezza, height: altezza, alignment: .center)
                                Text("Test Download Image ")
                                    .foregroundColor(.white)
                            }
                        })
                        
                    }
                    
                }
                
            }
            //            if showingAlert == true {
            //                AlertErrorLogin(showingAlert: $showingAlert)
            //            }
            //
            //            if showingAlertRegister == true {
            //                AlertErrorRegister(showingAlertRegister: $showingAlertRegister)
            //            }
            //
            //            if showingAlertField == true {
            //                AlertErrorField(showingAlertField: $showingAlertField)
            //            }
            //
            if (updateView == true) {
                UpdateView(userModel: userModel)
            }
            if (createEvents == true) {
                CreationView()
            }
            if (reservation == true) {
                ReservationView()
            }
            if (cameraQr == true) {
                ScannerView()
            }
            if ( testdownload == true) {
                TestDownloadImage()
            }
        }.navigationBarHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
private func showAppleLoginView() {
    print("ShowAppleLoginView")
}
