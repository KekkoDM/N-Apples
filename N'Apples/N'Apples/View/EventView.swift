//
//  EventView.swift
//  N'Apples
//
//  Created by Simona Ettari on 20/05/22.
//

import Foundation
import SwiftUI

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
    @State var notification: Bool = false
    @ObservedObject var pushNotification: CloudkitPushNotificationViewModel = CloudkitPushNotificationViewModel()
    
    var body: some View {
        
        ZStack {
            VStack (spacing: 70) {
                NavigationLink (destination: UpdateView(userModel: userModel), isActive: $presentUpdateView) {
                    Text("My Self")
                        .onTapGesture {
                            presentUpdateView.toggle()
                        }
                }
                
                VStack {
                    if(showEvents){
                        ForEach(0 ..< eventModel.event.count, id: \.self) { i in
                            NavigationLink (destination: RecapEventView(eventModel: $eventModel, i: $intero), isActive: $presentRecapEventView) {
                                Text(eventModel.event[i].name)
                                    .onTapGesture {
                                        intero = i
                                        presentRecapEventView.toggle()
                                        
                                    }
                            }
                            
                        }
                    }
                }
                
//                Button(action: {notification = true }, label: {Text("View Notification")})
                
                VStack (spacing: 20) {
                    NavigationLink (destination: CreationView(), isActive: $presentCreationView) {
                        Text("Create Event")
                            .onTapGesture {
                                presentCreationView.toggle()
                            }
                    }
                }
            }
//            if notification == true {
//                CloudkitPushNotification()
//            }
        }
        .onAppear(){
            
            pushNotification.requestNotificationPermission()
            
            Task{
                eventModel.records.removeAll()
                eventModel.event.removeAll()
                showEvents = try await retrieveMyEvents()
            }
        }
        
        .navigationTitle("My Event")
        .padding()
    }
}
