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
                    
                    //                    if showEvents {
                    //                        IMieiEventi(eventModel: eventModel, roleModel: roleModel)
                    //                    }
                    
                    
                    if !showCaricamento {
                        
                        VStack(spacing: 20){
                            ScrollView(showsIndicators: false) {
                                if roleModel.role.first!.permission == [0,0,0]{
                                    CardEvento(i: $intero, eventModel: $eventModel, Paramentri: [CardEvento.ParametriCard(titoloEvento: eventModel.event[0].name, location: eventModel.event[0].location, data: eventModel.event[0].timeForPrice, prenotazioniDisponibili: eventModel.event[0].capability, descrizioneEvento: eventModel.event[0].info, tariffeEntrata: eventModel.event[0].price, idEvent: eventModel.event[0].id )])}
                                ForEach(1 ..< eventModel.event.count, id: \.self) { i in
                                    if roleModel.role[i].permission == [0,0,0]{
                                    if(eventModel.event[i].name != eventModel.event[i-1].name && i != 0){
                                        CardEvento(i: $intero, eventModel: $eventModel, Paramentri: [CardEvento.ParametriCard(titoloEvento: eventModel.event[i].name, location: eventModel.event[i].location, data: eventModel.event[i].timeForPrice, prenotazioniDisponibili: eventModel.event[i].capability, descrizioneEvento: eventModel.event[i].info, tariffeEntrata: eventModel.event[i].price, idEvent: eventModel.event[i].id )])
                                        .onAppear(perform: {
                                            print(i)
                                        })
                                        .onTapGesture {
                                            intero = i
                                            
                                        }}}
                                }
                                
                                .refreshable {
                                    
                                    Task {
                                        try await userModel.retrieveAllId(id: userSettings.id)
                                        
                                        showEvents = false
                                        showEvents = try await retrieveMyEvents()
                                        print("Refresh")
                                        showCaricamento = false
                                        
                                        
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
                                
                                
                                
                                
                            }
                            
                            .sheet(isPresented: $showSheet, onDismiss: {
                                showCaricamento = true
                                
                                Task {
                                    try await userModel.retrieveAllId(id: userSettings.id)
                                    
                                    showEvents = false
                                    
                                    showEvents = try await retrieveMyEvents()
                                    
                                    showCaricamento = false
                                    
                                }
                            }) {
                                CreationView()
                            }
                            
                            
                            //                        .position(x: geometry.size.width * 0.45, y: geometry.size.height*0.45)
                            //
                            
                        }
                    }
                    //                    if showCaricamento {
                    //
                    //                            GifImage(stringaGif)
                    //
                    //                            .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
                    //                            .padding(.top, 200)
                    //
                    //                            .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.37)
                    //                            .background( Color(red: 11/255, green: 41/255, blue: 111/255))
                    //
                    //                    }
                    
                    
                }
                
                .navigationTitle("My Events")
                .navigationBarItems(trailing: Button(action: {
                    showSheet=true
                    print("UUUUUUUU")
                }) {
                    if !showCaricamento {
                        Image(systemName: "plus.circle.fill")}
                    
                })
                
                
            }
            
           
            .background(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
            
            
        }
        .navigationBarHidden(true)
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
    @Binding var i: Int
    @Binding var eventModel: EventModel
    
    struct ParametriCard: Identifiable {
        var id: String {
            self.titoloEvento
        }
        var titoloEvento: String
        var location: String
        var data: [Date]
        
        var prenotazioniDisponibili: Int
        var descrizioneEvento: String
        var tariffeEntrata: [Int]
        var idEvent: String
    }
    
    @State var Paramentri: [ParametriCard] = [ParametriCard(titoloEvento: "Arenile", location: "Caivano", data: [Date()],  prenotazioniDisponibili: 100, descrizioneEvento:"", tariffeEntrata: [0], idEvent: "")]
    
    
    var body: some View {
        
        
        ZStack {
            
            //            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
            //                .ignoresSafeArea()
            
            ForEach(Paramentri) {
                
                index in
                
                Image(uiImage: UIImage(named: "card")!)
                    .overlay(
                        VStack(spacing: 18) {
                            
                            VStack(alignment: .trailing, spacing: 1){
                                
                                
                                Image(systemName: "list.bullet.rectangle").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                //                                Text("Lists").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                //                                    .font(.system(size: 16))
                                NavigationLink(destination: {Lists()}, label: {
                                    Text("Lists")
                                        .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))})
                            }
                            
                            
                            
                            VStack(alignment: .trailing, spacing: 1){
                                Image(systemName: "person.text.rectangle")
                                    .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))      .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                //                                Text("Roles").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                //                                    .font(.system(size: 16))
                                NavigationLink(destination: {RoleView(i: $i, eventModel: $eventModel)}, label: {
                                    Text("Roles")
                                        .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))})
                               
                            }
                            
                        }
                    )
                
                    .overlay(
                        
                        VStack (alignment: .leading, spacing: 10) {
                            
                            NavigationLink(destination: Riepilogo(titolo: index.titoloEvento, location: index.location, data: index.data, prenotazioniDisponibili: String(index.prenotazioniDisponibili), descrizioneEvento: index.descrizioneEvento, tariffeEntrata: index.tariffeEntrata,idEvent:index.idEvent)) {
                                Text("\(index.titoloEvento)  >")
                                    .underline()
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 65)
                            }
                            
                            
                            HStack {
                                
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                                Text("\(index.location)")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 65)
                            
                            HStack{
                                Image(systemName: "calendar")
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                                Text("\(formattedDate(date:index.data.first!,format: "dd/MM" )) ")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 65)
                            
                            HStack {
                                
                                Image(systemName: "clock")
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                                Text("\(formattedDate(date:index.data.first!,format: "HH:mm" ))")
                                    .font(.system(size: 19))
                                    .foregroundColor(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 65)
                            
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



