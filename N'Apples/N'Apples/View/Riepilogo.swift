//
//  Riepilogo.swift
//  N'Apples
//
//  Created by Simona Ettari on 08/06/22.
//

import Foundation
import SwiftUI

struct Riepilogo: View {
    
    var titolo: String
    var location: String
    var data: Date
    var prenotazioniDisponibili: Int
    var descrizioneEvento: String
    var tariffeEntrata: [Int]
    
    struct ParametriRiepilogo: Identifiable {
        var id: String {
            self.titoloEvento }
        var titoloEvento: String
        var location: String
        var data: Date
        var ora: Date
        var prenotazioniDisponibili: Int
        var descrizioneEvento: String
        var tariffeEntrata: [Int]
        
    }
    
    @State var ParamentriRecap: [ParametriRiepilogo] = [ParametriRiepilogo(titoloEvento: "", location: "", data: Date(), ora: Date(), prenotazioniDisponibili: 100, descrizioneEvento: "", tariffeEntrata: [0])]
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
                                
                                Text("\(formattedDate(date:index.data,format: "dd/MM" )) ") .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            VStack(alignment: .leading, spacing: 7){
                                Text("Time")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(formattedDate(date:index.data,format: "HH:mm" ))")
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
                            Text("Delete Event").underline().foregroundColor(.red).padding()
                        }.frame(height: geometry.size.width * 0.4, alignment: .center)
                    }
                    .foregroundColor(.white)
                    
                    
                }
            }
            .onAppear(){
                ParamentriRecap = [ParametriRiepilogo(titoloEvento: titolo, location: location, data: data, ora: data, prenotazioniDisponibili: prenotazioniDisponibili, descrizioneEvento: descrizioneEvento, tariffeEntrata: tariffeEntrata)]
            }
            
        }
        
        .toolbar{
            NavigationLink(destination: Lists(), label: {
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

//struct Riepilogo_Previews: PreviewProvider {
//    static var previews: some View {
//        Riepilogo(titolo: "Titolo")
//    }
//}
