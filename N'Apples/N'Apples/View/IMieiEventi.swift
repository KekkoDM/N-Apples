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
    
    @State var stringaGif: String = "LoadingGif"
    @State var showEvents = false
    @State private var showCaricamento : Bool = false
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        
        NavigationView {
            
            GeometryReader{
                geometry in
                
                ZStack {
                    if showCaricamento {
                        
                            GifImage(stringaGif)
                           
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
                            .padding(.top, 200)
                            
                            .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.45)
                            .background( Color(red: 11/255, green: 41/255, blue: 111/255))
        
                    }
                    
                    if showEvents {
                        IMieiEventi(eventModel: eventModel, roleModel: roleModel)
                    }
                    
                 
                    if !showCaricamento {
                        
                        VStack(spacing: 20){
                            ScrollView( showsIndicators: false) {
                            
                            ForEach(0 ..< eventModel.event.count, id: \.self) { i in
                                                            
                                CardEvento(i: $intero, eventModel: $eventModel, Paramentri: [CardEvento.ParametriCard(titoloEvento: eventModel.event[i].name, location: eventModel.event[i].location, data: eventModel.event[i].date, ora: eventModel.event[i].date, prenotazioniDisponibili: eventModel.event[i].capability, descrizioneEvento: eventModel.event[i].info)])
                                    .onTapGesture {
                                        intero = i
                                        
                                    }
                            }
                            
                           
//                            Button(action: {
//                                showSheet = true
//                            })
//                            {
//                                Text("New Event")
//                                    .foregroundColor(.white)
//                                    .fontWeight(.bold)
//                                    .frame(width: 204, height: 59)
//                                    .background(RoundedRectangle(cornerRadius: 7).foregroundColor(.accentColor))
//                            }
                            
                            
                            .sheet(isPresented: $showSheet, onDismiss: {
                                showCaricamento = true
                    
                                Task {
                                    try await userModel.retrieveAllId(id: userSettings.id)
                                    
                                    print( userModel.user.first?.username ?? "prova")
                                    showEvents = false
                                    showEvents = try await retrieveMyEvents()
                                    print("SHOW Event: \(showEvents)")
                                    
                                    showCaricamento = false
                                   
                                    
                                    //                                   try await retrieveMyEvents()
                                }
                            }) {
                                CreationView()
                            }
                            
                        }
//                        .position(x: geometry.size.width * 0.45, y: geometry.size.height*0.45)
//
                        
                    }
                }
                    if showCaricamento {
                        
                            GifImage(stringaGif)
                           
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
                            .padding(.top, 200)
                            
                            .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.45)
                            .background( Color(red: 11/255, green: 41/255, blue: 111/255))
        
                    } }
                
//
                    
                    
                }
            
                .navigationTitle("My Events")
                .navigationBarItems(trailing: Button(action: {showSheet=true}) {
                    if !showCaricamento {
                        Image(systemName: "plus.circle.fill")}
                    
                })
            .background(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                
            }
            .searchable(text: $searchText2)
         
                
            }
            
        }
        
    
    
    
//    init() {
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//    }
    
    
//}


struct CardEvento: View {
//    let geometry: GeometryProxy
    @Binding var i:Int
    @Binding var eventModel: EventModel
    
    struct ParametriCard: Identifiable {
        var id: String {
            self.titoloEvento
        }
        var titoloEvento: String
        var location: String
        var data: Date
        var ora: Date
        var prenotazioniDisponibili:Int
        var descrizioneEvento:String
    }
    
    @State var Paramentri: [ParametriCard] = [ParametriCard(titoloEvento: "Arenile", location: "Caivano", data: Date(), ora: Date(),prenotazioniDisponibili:100,descrizioneEvento:"")]
    
    
    var body: some View {
        
        
        ZStack {
            
//            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
//                .ignoresSafeArea()
            
            ForEach(Paramentri) {
                
                index in
                
                Image(uiImage: UIImage(named: "card")!)
                    .overlay(
                        VStack(spacing: 18){
                          
                            
                         
                            
                            VStack(alignment: .trailing, spacing: 1){


                                Image(systemName: "list.bullet.rectangle").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 28))
                                    .padding(.leading, 290)

//                                Text("Lists").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
//                                    .font(.system(size: 16))
                                NavigationLink(destination: {Lists()}, label: {
                                    Text("Lists").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))})
                            }
                            
                            
                            
                            VStack(alignment: .trailing, spacing: 1){
                                Image(systemName: "person.text.rectangle")
                                    .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))              .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
//                                Text("Roles").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
//                                    .font(.system(size: 16))
                                NavigationLink(destination: {RoleView(i: $i, eventModel: $eventModel)}, label: {
                                    Text("Roles").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))})
                            }
                            
                        }
                    )
                
                    .overlay(
                        
                        VStack(alignment: .leading, spacing: 10){
                            
                            NavigationLink(destination: Riepilogo(titolo: index.titoloEvento, location: index.location, data: index.data, prenotazioniDisponibili: index.prenotazioniDisponibili, descrizioneEvento: index.descrizioneEvento)) {
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
                                
                                Text("\(formattedDate(date:index.data,format: "dd/MM" )) ")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                            }
                            
                            HStack{
                                
                                Image(systemName: "clock")
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                Text("\(formattedDate(date:index.data,format: "HH:mm" ))")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                            }
                            
                        }
                            .multilineTextAlignment(.leading)
//                            .position(x: 115, y: 70)
                        
                    )
            }
            
            
        }
        
    }
    func formattedDate(date:Date,format:String)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: date)
    }
}


//struct IMieiEventi_Previews: PreviewProvider {
//    static var previews: some View {
//        IMieiEventi()
//    }
//}



