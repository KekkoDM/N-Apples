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
      var idEvent:String
    
}
struct Riepilogo: View {
    @ObservedObject var userSettings = UserSettings()
    var titolo: String
    var location: String
    var data: [Date]
    var prenotazioniDisponibili: String
    var descrizioneEvento: String
    var tariffeEntrata: [Int]
    var idEvent:String
    @State var showEvents = false

    @State var stringaGif: String = "LoadingGif"
    @State private var showSheet : Bool = false
    @State private var showCaricamento : Bool = false
    
    @State var ParamentriRecap: [ParametriRiepilogo] = [ParametriRiepilogo(titoloEvento: "", location: "", data: [Date()],  prenotazioniDisponibili: "0", descrizioneEvento: "", tariffeEntrata: ["0"], idEvent: "")]
    var body: some View {
        
        
        
        GeometryReader{
            geometry in
            
            
            ZStack{
                
                Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                    .ignoresSafeArea()
                
                
                ForEach(ParamentriRecap) {
                    index in
                    
                    ScrollView{
                        
                        VStack(alignment: .leading, spacing: 23){
                            
                            VStack(alignment: .leading, spacing: 7){
                                
                                Text("\(index.titoloEvento)")
                                    .font(.system(size: 50, weight: .heavy, design: .default))
                            }
                            
                            
                            VStack(alignment: .leading, spacing: 7){
                                Text("Location")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(index.location)")
                                    .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            VStack(alignment: .leading, spacing: 7){
                                Text("Date")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(formattedDate(date:index.data[0],format: "dd/MM" )) ") .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            VStack(alignment: .leading, spacing: 7){
                                Text("Time")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(formattedDate(date:index.data[0],format: "HH:mm" ))")
                                    .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            VStack(alignment: .leading, spacing: 7){
                                Text("Available Reservations")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(index.prenotazioniDisponibili)")
                                    .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            VStack(alignment: .leading, spacing: 20){
                                
                                VStack(alignment: .leading, spacing: 7){
                                    Text("Event Description") .font(.system(size: 20, weight: .heavy, design: .default))
                                    
                                    Text("\(index.descrizioneEvento)")
                                        .font(.system(size: 30))
                                        .font(.system(.body, design: .monospaced))
                                    //                                        .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.3)
                                    
                                    
                                }
                                
                                VStack(alignment: .leading, spacing: 7){
                                    Text("Prices")
                                        .font(.system(size: 20, weight: .heavy, design: .default))
                                    
                                    
                                    Text(index.tariffeEntrata.description) .font(.system(size: 30))
                                        .font(.system(.body, design: .monospaced))
                                }
                                
                                
                            }
                            
                            Spacer()
                            
                            
                        }.padding()
                            .frame(width: geometry.size.width * 0.93, height: geometry.size.width * 1.4, alignment: .leading)
                        
                        VStack{
                            Button(action: {
                                Task{
                                    try await eventModel.delete(idEvent: idEvent)
                                }
                            }, label: {                            Text("Delete Event").underline().foregroundColor(.red).padding()
})
                        }.frame(height: geometry.size.width * 0.4, alignment: .center)
                    }
                    .foregroundColor(.white)
                    
                    
                }
                .sheet(isPresented: $showSheet, onDismiss: {
                    showCaricamento = true

                    Task {
                        try await userModel.retrieveAllId(id: userSettings.id)

                        print( userModel.user.first?.username ?? "prova")
                        showEvents = false
                        showEvents = try await retrieveMyEvents()
                        print("SHOW Event: \(showEvents)")
                        print("SHOW Caricamento: \(showCaricamento)")
                        print("Event Model: \(eventModel.records)")
                        showCaricamento = false

                        //                                   try await retrieveMyEvents()
                    }
                }) {
                    EditView( ParamentriRecap: $ParamentriRecap.first!) 
                }
                
                if showCaricamento {
                    
                    GifImage(stringaGif)
                    
                        .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
                        .padding(.top, 200)
                    
                        .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.37)
                        .background( Color(red: 11/255, green: 41/255, blue: 111/255))
                    
                }
                
                NavigationLink("", isActive: $showEvents, destination: {
                    IMieiEventi(eventModel: eventModel, roleModel: roleModel)})
                    
                
                
            
            }
            .onAppear(){
                ParamentriRecap = [ParametriRiepilogo(titoloEvento: titolo, location: location, data: data,  prenotazioniDisponibili: String(prenotazioniDisponibili) , descrizioneEvento: descrizioneEvento, tariffeEntrata: tariffeEntrata.map{String($0) ?? ""}, idEvent: idEvent )]

            }
            
        }
        
        .toolbar{
//            NavigationLink(destination: EditView( ParamentriRecap: $ParamentriRecap.first!) , label: {
//                Text("Edit")
//            }
//            )
            Button(action: {showSheet = true}, label: {      Text("Edit")})
        }
        
    }
    func formattedDate(date:Date,format:String)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: date)
    }
}

//struct Riepilogo_Previews: PreviewProvider {
//    static var previews: some View {
//        Riepilogo(titolo: "Titolo")
//    }
//}
