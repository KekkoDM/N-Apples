//
//  BigliettoValido.swift
//  N'Apples
//
//  Created by Simona Ettari on 14/06/22.
//

import Foundation
import SwiftUI

struct BigliettoValido: View {
    struct ParametriBiglietto:Identifiable {
        var id: String {
            self.nome }
        var nome: String
        var cognome: String
        var numeropersone: Int
        var nomepr: String
        var email: String
    }
    
    @State var Biglietto: [ParametriBiglietto] = [ParametriBiglietto(nome: "Domenico", cognome: "sdnsidn", numeropersone: 6, nomepr: "Nicola",email: "dom@gmail.com")]
    
    var body: some View {
        
        ZStack{
            GeometryReader{ geometry in
            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
            .ignoresSafeArea()
                VStack{
        Text("Biglietto Valido")
                        .foregroundColor(.green)
                .underline()
                .foregroundColor(.white)
                .font(.largeTitle)

                }
                .position(x: geometry.size.width*0.5, y: geometry.size.height*0.15)
                
                ForEach(Biglietto){ index in
                    VStack(alignment: .leading, spacing: 12){
                        Text("Booked by")
                            .underline()
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("\(index.nome)  \(index.cognome)")
                            .font(.title2)
                           
                        Text("N° of people invited")
                            .font(.headline)
                            .underline()
                            .foregroundColor(.gray)
                        
                        Text("\(index.numeropersone)")
                            .font(.title2)
                            
                        Text("Promoter")
                            .underline()
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("\(index.nomepr)")
                            .font(.title2)
                            
                        Text("E-mail")
                            .underline()
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("\(index.email)")
                            
                            .font(.title2)
                    }
                    
                    
                    .foregroundColor(.white)
                    .position(x: geometry.size.width*0.28, y: geometry.size.height*0.42)
                 
                }
                
                
            }
        }
    }
}

struct BigliettovalidoView_Previews: PreviewProvider {
    static var previews: some View {
        BigliettoValido()
    }
}

