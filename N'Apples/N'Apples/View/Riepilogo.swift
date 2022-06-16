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
    @State var tables: [String]
    
    
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
    @State var tables: [String]
    @Binding var indici:[Int]
    @Binding var i: Int
    @State var linkvar = ""
    @State var descrizione: String = ""
    @State var tariff: String = ""    
    @State var showEvents = false
    @State var showingAlertDelete: Bool = false
    @State var stringaGif: String = "LoadingGif"
    @State private var showSheet : Bool = false
    @State private var showCaricamento : Bool = false
    @State var showEventView = false
    @Binding var updateMain: Bool
    //    var str = "An apple a day, keeps doctor away!"
    
    
    @State var ParamentriRecap: [ParametriRiepilogo] = [ParametriRiepilogo(titoloEvento: "", location: "", data: [Date()],  prenotazioniDisponibili: "0", descrizioneEvento: "", tariffeEntrata: ["0"], idEvent: "", tables: [""])]
    var body: some View {
        
        GeometryReader {
            geometry in
            
            
            ZStack {
                
                Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                    .ignoresSafeArea()
                
                
                //                ForEach(ParamentriRecap) {
                //                    ParametriRecap.first! in
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 23) {
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
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
                            
                            
                            VStack(alignment: .leading, spacing: 12) {
                                HStack (spacing: 10){
                                    Text("Link Reservation") .font(.system(size: 20, weight: .heavy, design: .default))
                                    Button(action: {
                                        linkvar = "https://quizcode.altervista.org/API/discorganizer/Reservation.php?idEvent=\(ParamentriRecap.first!.idEvent)"
                                        UIPasteboard.general.string =  linkvar
                                    }, label: {
                                        Image(systemName: "doc.on.clipboard")
                                            .cornerRadius(5)
                                    })
                                    
                                }
                                
                                Link(destination: URL(string: "https://quizcode.altervista.org/API/discorganizer/Reservation.php?idEvent=\(ParamentriRecap.first!.idEvent)")!, label: {
                                    Text("https://inNight.com/Reservation.php?idEvent=\(ParamentriRecap.first!.idEvent)")
                                        .underline()
                                        .font(.italic(.system(size: 18))())
                                        .font(.system(.body, design: .monospaced))
                                        .frame(width: geometry.size.width * 0.86, height:geometry.size.height * 0.1,alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                })
                                
                             
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Prices")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                
                                
                                ForEach(1 ..< ParamentriRecap.first!.tables.count, id: \.self) {
                                    i in
                                    VStack(spacing: 10){
                                        priceCard2(prezzocard: $ParamentriRecap.first!.tariffeEntrata[i], tables: $ParamentriRecap.first!.tables[i])
                                            .frame(width: geometry.size.width * 0.86, height:geometry.size.height * 0.1)
                                    }
                                }
                                
                                
                                //                                    Text("\(tariff)") .font(.system(size: 30))
                                //                                        .font(.system(.body, design: .monospaced))
                                //
                                //                                    Text("\(descrizione)") .font(.system(size: 30))
                                //                                        .font(.system(.body, design: .monospaced))
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
                    }.padding(.top, 45)
                        .frame(height: geometry.size.width * 0.4, alignment: .center)
                }
                .foregroundColor(.white)
                
                
                //                }
                .sheet(isPresented: $showSheet, onDismiss: {
                    showCaricamento = true
                }) {
                    EditView(ParamentriRecap: $ParamentriRecap.first!, indici: $indici)
                }

                if showCaricamento {
                    GifFile(eventModel: eventModel, roleModel: roleModel, indici: $indici, endRetrieve: $showCaricamento, fromEdit: true)
                        .ignoresSafeArea()
                }
                
                
            }
            .onAppear(){
                ParamentriRecap = [ParametriRiepilogo(titoloEvento: titolo, location: location, data: data,  prenotazioniDisponibili: String(prenotazioniDisponibili) , descrizioneEvento: descrizioneEvento, tariffeEntrata: tariffeEntrata.map{String($0) }, idEvent: idEvent, tables: tables.map{String($0)})]
                
                
                //                descrizione = ParamentriRecap.first!.tables.description
                //                let removeCharacters: Set<Character> = ["[", ",", "\"", "]"]
                //                descrizione.removeAll(where: { removeCharacters.contains($0) } )
                //
                //
                //                tariff = ParamentriRecap.first!.tariffeEntrata.description
                //                let removeCharacter: Set<Character> = ["[", ",", "\"", "]"]
                //                tariff.removeAll(where: { removeCharacter.contains($0) } )
                //                tariff.removeFirst(1)
                
            }
            if (showingAlertDelete == true) {
                AlertDelete(show: $showingAlertDelete, showCaricamento: $showCaricamento)
            }
        }
        .onDisappear{
            updateMain.toggle()
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


struct priceCard2 : View {
    
    @Binding var prezzocard : String
    @Binding var tables: String
    
    var body : some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
            HStack {
                VStack(alignment:.leading){
                    Text(tables)
                        .fontWeight(.bold)
                }
                Spacer()
                Text(prezzocard)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.black)
            .padding(.horizontal)
        }
    }
    
}
