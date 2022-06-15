//
//  GifFile.swift
//  N'Apples
//
//  Created by Simona Ettari on 15/06/22.
//

import Foundation
import SwiftUI

struct GifFile: View {
    
    @State var stringaGif: String = "LoadingGif"
    @State var showEvents = false
    @State var eventModel: EventModel
    @State var roleModel: RoleModel
    @ObservedObject var userSettings = UserSettings()
    @Binding var indici: [Int]
    @State var presentEventView: Bool = false
    
    var body: some View {
        
            GeometryReader{
                geometry in
                
                ZStack {
                    
                    GifImage(stringaGif)
                    
                        .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
                        .padding(.top, 200)
                    
                        .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.45)
                        .background( Color(red: 11/255, green: 41/255, blue: 111/255))
                    
                    if(showEvents) {
                        NavigationLink("", isActive: $showEvents, destination: {
                            IMieiEventi(eventModel: eventModel, roleModel: roleModel, indici: $indici)})
                    } else {
                        
                        NavigationLink ("", destination: EventView(eventModel: eventModel, roleModel: roleModel), isActive: $presentEventView)
                        
                    }
                    
                    
                }.onAppear() {
                    Task {
                    
                        
                            
                            try await userModel.retrieveAllId(id: userSettings.id)
                            
                            showEvents = false
//                            eventModel.records.removeAll()
//                            eventModel.event.removeAll()
                            showEvents = try await retrieveMyEvents()
                          print("show events \(showEvents)")
                            indici.removeAll()
                            print("tappend \(roleModel.role.count)")
                             for i in 0 ..< roleModel.role.count + 1{
                                 print("tappend \(i)")
                                 indici.append(i)
                                 print("indice idea del secolo \(indici[i])")
                             }
            
                        
                        if(!showEvents) {
                            presentEventView = true
                        }
                    }
                }
            
        }
    }
}
