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
    @Binding var indici:[Int] 
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        
        NavigationView {
            
            GeometryReader{
                geometry in
                
                ZStack {
                    if showCaricamento {
                        
//                        GifImage(stringaGif)
//                        
//                            .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
//                            .padding(.top, 200)
//                        
//                            .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.45)
//                            .background( Color(red: 11/255, green: 41/255, blue: 111/255))
                        GifFile(eventModel: eventModel, roleModel: roleModel, indici: $indici)
                    }
                    
                    
//                    !showCaricamento &&
                    if  !roleModel.role.isEmpty {
                        
                        VStack(spacing: 20){
                            ScrollView(showsIndicators: false) {
//                                if roleModel.role.first!.permission == [0,0,0] ||  roleModel.role.first!.permission == [1,0,0] {
//
//                                        CardEvento(i: $indici[0], eventModel: $eventModel, roleModel: $roleModel, indici: $indici, Paramentri: [CardEvento.ParametriCard(titoloEvento: eventModel.event[0].name, location: eventModel.event[0].location, data: eventModel.event[0].timeForPrice, prenotazioniDisponibili: eventModel.event[0].capability, descrizioneEvento: eventModel.event[0].info, tariffeEntrata: eventModel.event[0].price, idEvent: eventModel.event[0].id, tables: eventModel.event[0].table )])
//
//
//
//                                }
//
//                                else  if roleModel.role.first!.permission == [0,0,1]  {
//                                    CardEvento2(i: $indici[0], eventModel: $eventModel, roleModel: $roleModel, indici: $indici, Paramentri: [CardEvento2.ParametriCard(titoloEvento: eventModel.event[0].name, location: eventModel.event[0].location, data: eventModel.event[0].timeForPrice, prenotazioniDisponibili: eventModel.event[0].capability, descrizioneEvento: eventModel.event[0].info, tariffeEntrata: eventModel.event[0].price, idEvent: eventModel.event[0].id, tables: eventModel.event[0].table )])
//
//
//
//                                }
//                                else  if roleModel.role.first!.permission == [0,1,0]  {
//                                    CardEvento3(i: $indici[0], eventModel: $eventModel, roleModel: $roleModel, indici: $indici, Paramentri: [CardEvento3.ParametriCard(titoloEvento: eventModel.event[0].name, location: eventModel.event[0].location, data: eventModel.event[0].timeForPrice, prenotazioniDisponibili: eventModel.event[0].capability, descrizioneEvento: eventModel.event[0].info, tariffeEntrata: eventModel.event[0].price, idEvent: eventModel.event[0].id, tables: eventModel.event[0].table )])
//
//                                        .onAppear(perform: {
//                                            intero = 0
//                                        })
//
//                                }
                                
                                ForEach(0 ..< eventModel.event.count, id: \.self) { i in
                                    
                                    
                                    if roleModel.role[i].permission == [0,0,0] || roleModel.role[i].permission == [1,0,0] {
                                        
//                                        if(eventModel.event[i].name != eventModel.event[i-1].name && i != 0){
                                            
                                            CardEvento(i: $indici[i], eventModel: $eventModel, roleModel: $roleModel, indici: $indici, Paramentri: [CardEvento.ParametriCard(titoloEvento: eventModel.event[i].name, location: eventModel.event[i].location, data: eventModel.event[i].timeForPrice, prenotazioniDisponibili: eventModel.event[i].capability, descrizioneEvento: eventModel.event[i].info, tariffeEntrata: eventModel.event[i].price, idEvent: eventModel.event[i].id, tables: eventModel.event[i].table )])
                                            
                                            
//                                        }
                                        
                                    }
                                    else  if roleModel.role[i].permission == [0,0,1] {
//                                        if(eventModel.event[i].name != eventModel.event[i-1].name && i != 0){
                                            CardEvento2(i: $indici[i], eventModel: $eventModel, roleModel: $roleModel, indici: $indici, Paramentri: [CardEvento2.ParametriCard(titoloEvento: eventModel.event[i].name, location: eventModel.event[i].location, data: eventModel.event[i].timeForPrice, prenotazioniDisponibili: eventModel.event[i].capability, descrizioneEvento: eventModel.event[i].info, tariffeEntrata: eventModel.event[i].price, idEvent: eventModel.event[i].id, tables: eventModel.event[i].table )])
                                                .onAppear(perform: {
                                                    
                                                    print("INTERO ON APP: \(intero)")
                                                })
                                                
                                            
//                                        }
                                        
                                    }
                                    else  if roleModel.role[i].permission == [0,1,0] {
//                                        if(eventModel.event[i].name != eventModel.event[i-1].name && i != 0){
                                            CardEvento3(i: $indici[i], eventModel: $eventModel, roleModel: $roleModel, indici: $indici, Paramentri: [CardEvento3.ParametriCard(titoloEvento: eventModel.event[i].name, location: eventModel.event[i].location, data: eventModel.event[i].timeForPrice, prenotazioniDisponibili: eventModel.event[i].capability, descrizioneEvento: eventModel.event[i].info, tariffeEntrata: eventModel.event[i].price, idEvent: eventModel.event[i].id, tables: eventModel.event[i].table )])
                                                
                                                .onAppear(perform: {
                                                
                                                    print("INTERO ON APP: \(intero)")
                                                })
                                                
                                            
//                                        }
                                        
                                    }
                                }
                                
                                .refreshable {
                                    
                                    Task {
                                    
                                        try await userModel.retrieveAllId(id: userSettings.id)
                                        
                                        showEvents = false
                                        eventModel.records.removeAll()
                                        eventModel.event.removeAll()
                                       

                                        showEvents = try await retrieveMyEvents()
                                        print("Refresh")
                                        showCaricamento = false
                                        
                                        
                                    }
                                }
                                
                            }
                            
                            .sheet(isPresented: $showSheet, onDismiss: {
                                showCaricamento = true
                                
//                                Task {
////                                    indici.append(indici.count + 1)
//
//                                    try await userModel.retrieveAllId(id: userSettings.id)
//
//                                    showEvents = false
//                                    eventModel.records.removeAll()
//                                    eventModel.event.removeAll()
//                                    showEvents = try await retrieveMyEvents()
//
//                                    showCaricamento = false
//
//
//                                }
                            }) {
                                CreationView( indici: $indici)
                            }
                            
                            
                            
                        }
                    }
                    
                    
                }
                
                .navigationTitle("My Events")
                .navigationBarItems(trailing: Button(action: {
                    showSheet=true
                    
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



struct CardEvento: View {
    
    @Binding var i: Int
    @Binding var eventModel: EventModel
    @Binding var roleModel: RoleModel
    
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
        var tables: [String]
    }
    @Binding var indici:[Int]

    @State var Paramentri: [ParametriCard] = [ParametriCard(titoloEvento: "Arenile", location: "Caivano", data: [Date()],  prenotazioniDisponibili: 100, descrizioneEvento:"", tariffeEntrata: [0], idEvent: "", tables: [""])]
    @State var presentRoleView: Bool = false
    
    var body: some View {
        
        
        ZStack {
            
            
            ForEach(Paramentri) {
                
                index in
                
                Image(uiImage: UIImage(named: "card")!)
                
                    .overlay(
                        VStack(spacing: 18) {
                            
                            VStack(alignment: .trailing, spacing: 1){
                                
                                
                                Image(systemName: "list.bullet.rectangle").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                NavigationLink(destination: {Lists()}, label: {
                                    Text("Lists")
                                        .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))})
                            }
                            
                            
                            
                            VStack(alignment: .trailing, spacing: 1){
                                Image(systemName: "person.text.rectangle")
                                    .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                NavigationLink (destination: RoleView(i: $i, eventModel: $eventModel, roleModel: $roleModel, indici: $indici), isActive: $presentRoleView) {
                                    Text("Roles")
                                        .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                        .font(.system(size: 16))
                                        .onTapGesture {
                                            presentRoleView.toggle()
                                            
                                        }
                               
                                        
                                }.onAppear {
                                    if(presentRoleView){
                                        print("INToo: \(i)")
                                        print("INToo ev: \(eventModel.event[i].id)")
                                        
                                    }
                                    
                                }
                                
//                                NavigationLink(destination: {
//
//                                    RoleView(i: $i, eventModel: $eventModel)
//
//                                }, label: {
//                                    Text("Roles")
//                                        .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
//                                        .font(.system(size: 16))
//
//
//                                })
                                
                            }
                            
                        }
                    )
                
                
                
                    .overlay (
                        
                        VStack (alignment: .leading, spacing: 10) {
                            
                            NavigationLink(destination: Riepilogo(titolo: index.titoloEvento, location: index.location, data: index.data, prenotazioniDisponibili: String(index.prenotazioniDisponibili), descrizioneEvento: index.descrizioneEvento, tariffeEntrata: index.tariffeEntrata,idEvent:index.idEvent, tables: index.tables, indici: $indici, i: $i)) {
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





struct CardEvento2: View {
    
    @Binding var i: Int
    @Binding var eventModel: EventModel
    @Binding var roleModel: RoleModel
    @Binding var indici:[Int]

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
        var tables: [String]
    }
    
    @State var Paramentri: [ParametriCard] = [ParametriCard(titoloEvento: "Arenile", location: "Caivano", data: [Date()],  prenotazioniDisponibili: 100, descrizioneEvento:"", tariffeEntrata: [0], idEvent: "", tables: [""])]
    
    
    var body: some View {
        
        
        ZStack {
            
            
            ForEach(Paramentri) {
                
                index in
                
                
                Image(uiImage: UIImage(named: "card")!)
                
                    .overlay(
                        VStack(spacing: 18) {
                            
                            VStack(alignment: .trailing, spacing: 1){
                                
                                
                                Image(systemName: "list.bullet.rectangle").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                NavigationLink(destination: {Lists()}, label: {
                                    Text("Lists")
                                        .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))})
                            }
                            
                            
                            
                            VStack(alignment: .trailing, spacing: 1){
                                Image(systemName: "camera")
                                    .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))      .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                NavigationLink(destination: {
                                    ScannerView()
                                }, label: {
                                    Text("Scanner")
                                        .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))})
                                
                            }
                            
                        }
                    )
                
                
                
                    .overlay (
                        
                        VStack (alignment: .leading, spacing: 10) {
                            
                            NavigationLink(destination: Riepilogo(titolo: index.titoloEvento, location: index.location, data: index.data, prenotazioniDisponibili: String(index.prenotazioniDisponibili), descrizioneEvento: index.descrizioneEvento, tariffeEntrata: index.tariffeEntrata,idEvent:index.idEvent, tables: index.tables, indici: $indici, i: $i)) {
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

struct CardEvento3: View {
    
    @Binding var i: Int
    @Binding var eventModel: EventModel
    @Binding var roleModel: RoleModel
    @Binding var indici:[Int]

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
        var tables: [String]
    }
    
    @State var Paramentri: [ParametriCard] = [ParametriCard(titoloEvento: "Arenile", location: "Caivano", data: [Date()],  prenotazioniDisponibili: 100, descrizioneEvento:"", tariffeEntrata: [0], idEvent: "", tables: [""])]
    
    
    var body: some View {
        
        
        ZStack {
            
            
            ForEach(Paramentri) {
                
                index in
                
                
                Image(uiImage: UIImage(named: "card")!)
                
                    .overlay(
                        VStack(spacing: 18) {
                            
                            VStack(alignment: .trailing, spacing: 1){
                                
                                
                                Image(systemName: "list.bullet.rectangle").foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                NavigationLink(destination: {Lists()}, label: {
                                    Text("Lists")
                                        .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))})
                            }
                            
                            
                            
                            VStack(alignment: .trailing, spacing: 1){
                                Image(systemName: "person.badge.plus")
                                    .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))      .font(.system(size: 28))
                                    .padding(.leading, 290)
                                
                                NavigationLink(destination: {
                                    ReservationView (event: eventModel.event.first ?? Event())
                                }, label: {
                                    Text("Reservazion")
                                        .foregroundColor( Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                                    .font(.system(size: 16))})
                                
                            }
                            
                        }
                    )
                
                
                
                    .overlay (
                        
                        VStack (alignment: .leading, spacing: 10) {
                            
                            NavigationLink(destination: Riepilogo(titolo: index.titoloEvento, location: index.location, data: index.data, prenotazioniDisponibili: String(index.prenotazioniDisponibili), descrizioneEvento: index.descrizioneEvento, tariffeEntrata: index.tariffeEntrata,idEvent:index.idEvent, tables: index.tables, indici: $indici, i: $i)) {
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
