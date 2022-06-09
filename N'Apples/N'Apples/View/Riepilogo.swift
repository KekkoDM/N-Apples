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
    
    
    struct ParametriRiepilogo:Identifiable {
        var id: String {
            self.titoloEvento }
        var titoloEvento: String
        var location: String
        var data: String
        var ora: String
        var prenotazioniDisponibili: Int
        var descrizioneEvento: String
        var tariffeEntrata: String
        
    }
    @State var ParamentriRecap: [ParametriRiepilogo] = [ParametriRiepilogo(titoloEvento: "", location: "Bagnoli", data: "11/05", ora: "22:00", prenotazioniDisponibili: 100, descrizioneEvento: "aaaa", tariffeEntrata: "10 euro")]
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
                                
                                Text("\(index.data)")   .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            VStack(alignment: .leading, spacing: 7){
                                Text("Time")
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
                                Text("\(index.ora)")   .font(.system(size: 30))
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            VStack(alignment: .leading, spacing: 7){
                                Text("Available Reservations")                    .font(.system(size: 20, weight: .heavy, design: .default))
                                
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
                                    
                                    
                            Text("\(index.tariffeEntrata)") .font(.system(size: 30))
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
                 ParamentriRecap = [ParametriRiepilogo(titoloEvento: titolo, location: "Bagnoli", data: "11/05", ora: "22:00", prenotazioniDisponibili: 100, descrizioneEvento: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa", tariffeEntrata: "10 euro")]
            }
            
        }
        
        .toolbar{
            NavigationLink(destination: Lists(), label: {
                Text("Edit")
            })
            
        }
        
    }
}

struct Riepilogo_Previews: PreviewProvider {
    static var previews: some View {
        Riepilogo(titolo: "Titolo")
    }
}
