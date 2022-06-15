//
//  EventView.swift
//  N'Apples
//
//  Created by Simona Ettari on 20/05/22.
//

import Foundation
import SwiftUI
var provacaricamento = true

struct EventView: View {
    
    @State var presentCreationView: Bool = false
    @State var presentUpdateView: Bool = false
    @State var presentRecapEventView: Bool = false
    @State var eventModel: EventModel
    @State var roleModel: RoleModel
    @State var role: Role = Role()
    @State var image: UIImage = UIImage()
    @State var intero: Int = 0
    @State var showEvents = false
    @ObservedObject var pushNotification: CloudkitPushNotificationViewModel = CloudkitPushNotificationViewModel()
    @ObservedObject var userSettings = UserSettings()
//    @State var indici:[Int] = [0,1,2,3,4,5,6,7,8,9]
    @State var indici:[Int] = Array( repeating: 0,count: 300)

    @State var title = ""
    @State var stringaGif: String = "LoadingGif"
    @State var showSheet : Bool = false
    @State private var showCaricamento : Bool = false
    
    
    //        NavigationView {
    //            ZStack {Color.white
    //
    //                VStack (spacing: 70) {
    //
    //                    NavigationLink (destination: UpdateView(userModel: userModel), isActive: $presentUpdateView) {
    //                        Text("My Self")
    //                            .onTapGesture {
    //                                presentUpdateView.toggle()
    //                            }
    //                    }
    //
    //                    VStack {
    //                        if(showEvents){
    //                            ForEach(0 ..< eventModel.event.count, id: \.self) { i in
    //                                NavigationLink (destination: RecapEventView(eventModel: $eventModel, i: $intero), isActive: $presentRecapEventView) {
    //                                    Text(eventModel.event[i].name)
    //
    //                                        .onTapGesture {
    //                                            intero = i
    //                                            presentRecapEventView.toggle()
    //
    //                                        }
    //                                }
    //
    //                            }
    //                        }
    //                    }
    //
    //
    //
    //                    VStack (spacing: 20) {
    //                        Button(action: {
    //                            presentCreationView.toggle()
    //                        }
    //                               , label: {
    //                            Text("Create Event")
    //
    //                        })
    //
    //
    //                    }
    //                }
    //            }
    //
    //            .sheet(isPresented: $presentCreationView) {
    //                CreationView()
    //            }
    //            .onAppear(){
    //
    //                pushNotification.requestNotificationPermission()
    //                //            pushNotification.subscribe(textType: "Role", userName: userModel.user.first!.username)
    //
    //
    //
    //                Task {
    //                    try await userModel.retrieveAllId(id: userSettings.id)
    //
    //                    print( userModel.user.first?.username ?? "prova")
    //                    showEvents = false
    //                    showEvents = try await retrieveMyEvents()
    //
    //                    //                                   try await retrieveMyEvents()
    //                }
    //
    //            }
    //
    //            .navigationTitle("My Event")
    //            .padding()
    //        }
    
    var body: some View {
   
            NavigationView {
                GeometryReader { geometry in
                    
                    ZStack {
                        
                        Color(red: 11/255, green: 41/255, blue: 111/255)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 20){
                            Image("newevent")
                            
                            Text("You haven’t organized an event yet.")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 250, height: 90)
                                .multilineTextAlignment(.center)
                            
                            
                            Button(action: {
                                showSheet = true
                            })
                            {
                                Text("New Event")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .frame(width: 204, height: 59)
                                    .background(RoundedRectangle(cornerRadius: 7).foregroundColor(.accentColor))
                            }
                            
                            
                            
                        }
                        
                        
                        .sheet(isPresented: $showSheet, onDismiss: {
                            showCaricamento = true

//                            Task {
//                                try await userModel.retrieveAllId(id: userSettings.id)
//
//                                showEvents = false
//                                print("tappend \(eventModel.event.count)")
//                                eventModel.records.removeAll()
//                                eventModel.event.removeAll()
//                                showEvents = try await retrieveMyEvents()
//                                showCaricamento = false
//
//
//
//
//                            }
                            
                            
                        }) {
                            CreationView(indici: $indici)
                        }
                        
                        if showCaricamento {
                            
//                            GifImage(stringaGif)
//
//                                .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
//                                .padding(.top, 200)
//
//                                .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.37)
//                                .background( Color(red: 11/255, green: 41/255, blue: 111/255))
//                                .onAppear() {
//                                    print("DENTRO SHOW CARICAMENTO IN EVENT VIEW")
//
//
//
//                                }
                            GifFile(eventModel: eventModel, roleModel: roleModel, indici: $indici)
                        }
                        
//                        NavigationLink("", isActive: $showEvents, destination: {
//                            IMieiEventi(eventModel: eventModel, roleModel: roleModel, indici: $indici)})
//
                        
                    }
                   
                    
                    .onAppear(){
                        pushNotification.requestNotificationPermission()
//                        print("DENTRO ON APPEAR IN EVENT VIEW")
                        if provacaricamento {
                            showCaricamento = true
                            provacaricamento = false
                        }
                        title = "My Events"
                        
//                        Task {
//
//                            try await userModel.retrieveAllId(id: userSettings.id)
//
//                            showEvents = false
////                            eventModel.records.removeAll()
////                            eventModel.event.removeAll()
//                            showEvents = try await retrieveMyEvents()
//
//                            showCaricamento = false
//                            title = "My Events"
//                            indici.removeAll()
//                            print("tappend \(roleModel.role.count)")
//                             for i in 0 ..< roleModel.role.count + 1{
//                                 print("tappend \(i)")
//                                 indici.append(i)
//                                 print("indice idea del secolo \(indici[i])")
//                             }
//
//                        }
                        
                    }
                    
                    .navigationTitle(title)
                   
                    .navigationBarItems(trailing: Button(action: {showSheet=true}) {
                        if !showCaricamento {
                            Image(systemName: "plus.circle.fill")
                            
                        }
                        
                    })
                    
                }
                
            } .navigationBarHidden(true)
            
 
    }
    
}
