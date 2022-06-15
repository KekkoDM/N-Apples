//
//  Riepilogo.swift
//  N'Apples
//
//  Created by Simona Ettari on 08/06/22.
//

import Foundation
import SwiftUI


struct ParametriRiepilogo: Identifiable {
    var id: String {
        self.titoloEvento }
    var titoloEvento: String
    var location: String
    var data: [Date]
    var prenotazioniDisponibili: String
    var descrizioneEvento: String
    var tariffeEntrata: [String]
    var idEvent: String
    var tables: [String]
    
}


struct Riepilogo: View {
    @ObservedObject var userSettings = UserSettings()
    var titolo: String
    var location: String
    var data: [Date]
    var prenotazioniDisponibili: String
    var descrizioneEvento: String
    var tariffeEntrata: [Int]
    var idEvent: String
    var tables: [String]
    @Binding var indici:[Int]
    @Binding var i: Int

    @State var showEvents = false
    @State var showingAlertDelete: Bool = false
    @State var stringaGif: String = "LoadingGif"
    @State private var showSheet : Bool = false
    @State private var showCaricamento : Bool = false
    @State var showEventView = false
    
    @State var ParamentriRecap: [ParametriRiepilogo] = [ParametriRiepilogo(titoloEvento: "", location: "", data: [Date()],  prenotazioniDisponibili: "0", descrizioneEvento: "", tariffeEntrata: ["0"], idEvent: "", tables: [""])]
    var body: some View {
        
        GeometryReader {
            geometry in
            
            
            ZStack {
                
                Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                    .ignoresSafeArea()
                
                
//                ForEach(ParamentriRecap) {
//                    ParametriRecap.first! in
                    
                    ScrollView{
                        
                        VStack(alignment: .leading, spacing: 23) {
                            
                            VStack(alignment: .leading, spacing: 7) {
                                
                                Text("\(ParamentriRecap.first!.titoloEvento )")
                                    .font(.system(size: 50, weight: .heavy, design: .default))
                            }
                            
                            
                            VStack(alignment: .leading, spacing: 7) {
                                Text("Location")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(ParamentriRecap.first!.location)")
                                    .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            VStack(alignment: .leading, spacing: 7) {
                                Text("Date")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(formattedDate(date:ParamentriRecap.first!.data[0],format: "dd/MM" )) ") .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            VStack(alignment: .leading, spacing: 7) {
                                Text("Time")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(formattedDate(date:ParamentriRecap.first!.data[0],format: "HH:mm" ))")
                                    .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            VStack(alignment: .leading, spacing: 7) {
                                Text("Available Reservations")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(ParamentriRecap.first!.prenotazioniDisponibili)")
                                    .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            VStack(alignment: .leading, spacing: 20) {
                                
                                VStack(alignment: .leading, spacing: 7) {
                                    Text("Event Description") .font(.system(size: 20, weight: .heavy, design: .default))
                                    
                                    Text("\(ParamentriRecap.first!.descrizioneEvento)")
                                        .font(.system(size: 30))
                                        .font(.system(.body, design: .monospaced))
                                    
                                }
                                
                                VStack(alignment: .leading, spacing: 7) {
                                    Text("Prices")
                                        .font(.system(size: 20, weight: .heavy, design: .default))
                                    Text("\(ParamentriRecap.first!.tariffeEntrata.description)") .font(.system(size: 30))
                                        .font(.system(.body, design: .monospaced))
                                    Text("\(ParamentriRecap.first!.tables.description)") .font(.system(size: 30))
                                        .font(.system(.body, design: .monospaced))
                                }
                                
                                    
                                    //                                    ForEach(0..<ParametriRecap.first!.tariffeEntrata.count) {
                                    //                                        i in
                                    //                                        Text("\(ParametriRecap.first!.tariffeEntrata[i])") .font(.system(size: 30))
                                    //                                            .font(.system(.body, design: .monospaced))
                                    //                                    }
                                    //
                                    
//                                                                        ForEach(){ datino in
//
//                                                                        }
                                    
                                    
//                                                                        if ParamentriRecap.first!.data.count > 1 {
//
//                                                                            ForEach( 2 ..< ParamentriRecap.first!.data.count, id: \.self){ i in
//
////                                                                            if (i % 2 == 0) {
//
//                                                                                priceCard(orariocard: ParamentriRecap.first!.data[i-1], orariocardfine: ParamentriRecap.first!.data[i], prezzocard: ParamentriRecap.first!.tariffeEntrata[i], tables: ParamentriRecap.first!.tables[i])
//
//                                                                                    .onLongPressGesture {
//                                                                                        intero = i
//                                                                                        openAlert.toggle()
//
//                                                                                    }
//
//                                                                                .frame(width: geometry.size.width * 0.92, height:geometry.size.height * 0.1)
////                                                                            }
//
//                                                                        }
//
//                                                                        }
                                    
                                    
//
//                                                                        Text(ParametriRecap.first!.tables.description) .font(.system(size: 30))
//                                                                            .font(.system(.body, design: .monospaced))
//                                    priceCard2(orariocard: $ParamentriRecap.first!.data, prezzocard: $ParamentriRecap.first!.tariffeEntrata, tables: $ParamentriRecap.first!.tables)
                                    
                               
                                
                                
                            }
                            
                            Spacer()
                            
                            
                        }.padding()
                            .frame(width: geometry.size.width * 0.93, height: geometry.size.width * 1.4, alignment: .leading)
                        
                        VStack {
                            Button(action: {
                                Task {
//                                    try await eventModel.retrieveAllName(name: titolo)
                                    try await eventModel.delete(idEvent: idEvent)
                                    indici.remove(at: i)
                                    showingAlertDelete.toggle()
                                    
                                }
                            }, label: {
                                Text("Delete Event").underline().foregroundColor(.red).padding()
                            })
                        }.frame(height: geometry.size.width * 0.4, alignment: .center)
                    }
                    .foregroundColor(.white)
                    
                    
//                }
                .sheet(isPresented: $showSheet, onDismiss: {
                    showCaricamento = true
                    
//                    Task {
//                        try await userModel.retrieveAllId(id: userSettings.id)
//
//                        showEvents = false
//                        eventModel.records.removeAll()
//                        eventModel.event.removeAll()
//                        showEvents = try await retrieveMyEvents()
//                        showCaricamento = false
//
//                    }
                }) {
                    EditView(ParamentriRecap: $ParamentriRecap.first!)
                }
                
//                if showCaricamento {
//
////                    GifImage(stringaGif)
////
////                        .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
////                        .padding(.top, 200)
////
////                        .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.37)
////                        .background( Color(red: 11/255, green: 41/255, blue: 111/255))
//                    GifFile(eventModel: eventModel, roleModel: roleModel, indici: $indici)
//                }
//
                NavigationLink("", isActive: $showCaricamento, destination: {
                    GifFile(eventModel: eventModel, roleModel: roleModel, indici: $indici)})
                
//                NavigationLink("", isActive: $showEvents, destination: {
//                    IMieiEventi(eventModel: eventModel, roleModel: roleModel, indici: $indici)})
//
//
//                NavigationLink("", isActive: $showEventView, destination: {
//                    EventView(eventModel: eventModel, roleModel: roleModel)})
                
                
            }
            .onAppear(){
                ParamentriRecap = [ParametriRiepilogo(titoloEvento: titolo, location: location, data: data,  prenotazioniDisponibili: String(prenotazioniDisponibili) , descrizioneEvento: descrizioneEvento, tariffeEntrata: tariffeEntrata.map{String($0) }, idEvent: idEvent, tables: tables.map{String($0)})]
                
            }
            if (showingAlertDelete == true) {
                AlertDelete(show: $showingAlertDelete, showCaricamento: $showCaricamento)
            }
        }
        
        .toolbar {
            
            Button(action: {
                showSheet = true
            }, label: {
                Text("Edit")
                
            })
        }
        
    }
    func formattedDate(date:Date,format:String)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: date)
    }
}
//
////
//struct priceCard2 : View {
//    //    @Binding var titolocard : String
//    @Binding var orariocard : [Date]
//
//
//    @Binding var prezzocard : [String]
//    @Binding var tables: [String]
//    var body : some View {
//        Text("")
//        if orariocard.count > 1 {
//
//            ForEach( 2 ..< orariocard.count, id: \.self){ i in
//
//                if (i % 2 == 0) {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .foregroundColor(.white)
//                        HStack {
//                            VStack(alignment:.leading){
//                                Text(tables[i])
//                                    .fontWeight(.bold)
//                                Text("\(formattedDate(date:orariocard[i-1],format: "HH:mm")) - \(formattedDate(date:orariocard[i],format: "HH:mm"))")
//                            }
//                            Spacer()
//                            Text(prezzocard[i])
//                                .fontWeight(.semibold)
//                        }
//                        .foregroundColor(.black)
//                        .padding(.horizontal)
//                    }
//                }
//            }
//
//        }}
//    func formattedDate(date:Date,format:String)->String{
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = format
//        return dateformatter.string(from: date)
//    }
//}
