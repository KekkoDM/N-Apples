//
//  IMieiEventi.swift
//  N'Apples
//
//  Created by Simona Ettari on 08/06/22.
//

import Foundation
import SwiftUI

struct IMieiEventi: View {
    
    @State var searchText2: String = ""
    @State var eventModel: EventModel
    @State var roleModel: RoleModel
    @State var intero: Int = 0
    @State var showSheet = false
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader{
                geometry in
                
                ZStack{
                    
                    Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        
                        VStack(spacing: 20){
                            
                            ForEach(0 ..< eventModel.event.count, id: \.self) { i in
                                                            
                                CardEvento(geometry: geometry, Paramentri: [CardEvento.ParametriCard(titoloEvento: eventModel.event[i].name, location: eventModel.event[i].location, data: "\(eventModel.event[i].date)", ora: "\(eventModel.event[i].date)")])
                                    .onTapGesture {
                                        intero = i
                                        //                                                                      presentRecapEventView.toggle()
                                        
                                    }
                            }
                            
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
                            
                            
                            .sheet(isPresented: $showSheet) {
                                CreationView()
                            }
                            
                        }
                        
                        
                        }
                    }.padding(.trailing, 25).padding(.top)
                    
                    
                }
                
                .navigationTitle("My Events")
            }
            .searchable(text: $searchText2)
            .toolbar{
                NavigationLink(destination: Lists(), label: {
                    Image(systemName: "plus.circle.fill")
                })
                
            }
            
        }
        
    }
    
    
//    init() {
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//    }
    
    
//}


struct CardEvento: View {
    let geometry: GeometryProxy
    
    struct ParametriCard: Identifiable {
        var id: String {
            self.titoloEvento
        }
        var titoloEvento: String
        var location: String
        var data: String
        var ora: String
        
    }
    
    @State var Paramentri: [ParametriCard] = [ParametriCard(titoloEvento: "Arenile", location: "Caivano", data: "22/06", ora: "00:00")]
    
    
    var body: some View {
        
        
        ZStack {
            
            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                .ignoresSafeArea()
            
            ForEach(Paramentri) {
                
                index in
                
                Image(uiImage: UIImage(named: "card")!)
                    .overlay(
                        VStack(spacing: 18){
                            
                            VStack(alignment: .trailing, spacing: 1){
                                
                                
                                Image(systemName: "list.bullet.rectangle").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                Text("Lists").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))
                            }
                            
                            
                            
                            VStack(alignment: .trailing, spacing: 1){
                                Image(systemName: "person.text.rectangle")
                                    .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))              .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                Text("Roles").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))
                            }
                            
                        }
                    )
                
                    .overlay(
                        
                        VStack(alignment: .leading, spacing: 10){
                            
                            NavigationLink(destination: Riepilogo(titolo: index.titoloEvento)) {
                                Text("\(index.titoloEvento)  >")
                                    .underline()
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                            }
                            
                            
                            
                            HStack {
                                
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                Text("\(index.location)")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                            }
                            
                            HStack{
                                Image(systemName: "calendar")
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                                Text("\(index.data)")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                            }
                            
                            HStack{
                                
                                Image(systemName: "clock")
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                Text("\(index.ora)")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                            }
                            
                        }
                            .position(x: geometry.size.width * 0.3, y: geometry.size.height * 0.099)
                    )
            }
            
            
        }
        
    }
}


//struct IMieiEventi_Previews: PreviewProvider {
//    static var previews: some View {
//        IMieiEventi()
//    }
//}



