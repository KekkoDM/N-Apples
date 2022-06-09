//
//  InsideList.swift
//  N'Apples
//
//  Created by Simona Ettari on 08/06/22.
//

import Foundation
import SwiftUI

struct InsideList: View {
    
    struct Prenotati:Identifiable {
        var id: String {
            self.namePrenotato }
        var namePrenotato: String
        var surnamePrenotato: String
        var invitati: Int
    }
    @State var Prenotazioni: [Prenotati] = [Prenotati(namePrenotato:"Nicola",surnamePrenotato:"D'Abrosca",invitati:10)]
    
    var body: some View {
        
        
        
            GeometryReader{
                
                geometry in
                
                Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                    .ignoresSafeArea()
                
                ScrollView{
                    ForEach(Prenotazioni) {
                        
                        index in
                        
                        VStack(spacing: 30){
                            
                            
                            
                            VStack{
                                HStack(spacing: 140){
                        Text("\(index.namePrenotato) \(index.surnamePrenotato)")
                                        Text("+ \(index.invitati)")
                                    }
                                
                                ExDivider()
                                    .frame(width: geometry.size.width * 0.94, height: geometry.size.width * 0)
                                
                            }
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.1)

                            
                            
                            
                            
                            VStack{
                                HStack(spacing: 140){
                        Text("\(index.namePrenotato) \(index.surnamePrenotato)")
                                        Text("+ \(index.invitati)")
                                    }
                                
                                ExDivider()
                                    .frame(width: geometry.size.width * 0.94, height: geometry.size.width * 0)
                                
                            }
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.1)
                            
                            
                            
                        }
                        
                 
        
                        
                    }
                    
                }
                
                
                
                .navigationTitle("Tutti i prenotati")
                
                
            }
        
        
        
        
    }

    
    
    
    struct InsideList_Previews: PreviewProvider {
        static var previews: some View {
            InsideList()
        }
    }
}

struct ExDivider: View {
    var color: Color = .white
    var width: CGFloat = 1.5
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
        
    }
}
