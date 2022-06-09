//
//  TuttiIPrenotatiCard.swift
//  N'Apples
//
//  Created by Simona Ettari on 08/06/22.
//

import Foundation
import SwiftUI

struct TuttiIPrenotatiCard: View {
    
    var TuttiIPrenotati = [1, 2, 3]
    var body: some View {
        
        
        
        GeometryReader{
            
            geometry in
            
            ZStack{
                HStack{
                    
                    Text("Tutti i prenotati")
                    
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }.foregroundColor(.white)
                    .padding(.trailing, 160)
                    .frame(width: geometry.size.width*0.95, height: geometry.size.height*0.11)
                    .background(Rectangle().frame(width: geometry.size.width*0.95, height: geometry.size.height*0.11)
                        .cornerRadius(10, corners: [.topLeft, .bottomRight])
                        .shadow(radius: 2, y: 2))
                    .foregroundColor(Color(red: 0.19, green: 0.28, blue: 0.51))
                
                
                
                HStack(spacing: 20){
                    Divider().background(.white)
                        .frame(width: geometry.size.width * 0, height: geometry.size.width * 0.15)
                    
                    
                    Text("\(TuttiIPrenotati[0] )")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }.padding(.leading, 240)
                
   
            }
            
            
        }

        
    }
}

struct TuttiIPrenotatiCard_Previews: PreviewProvider {
    static var previews: some View {
        TuttiIPrenotatiCard()
    }
}
