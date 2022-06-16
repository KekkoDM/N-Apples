//
//  BigliettoNonValido.swift
//  N'Apples
//
//  Created by Simona Ettari on 14/06/22.
//

import Foundation
import SwiftUI

struct BigliettoNonValido: View {
    @Binding var showRecap: Bool
    var body: some View {
        ZStack{
            GeometryReader{ geometry in
            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
            .ignoresSafeArea()
                
                Text("Biglietto Invalido")
                .underline()
                .foregroundColor(.red)
                .font(.largeTitle)
                .position(x: geometry.size.width*0.5, y: geometry.size.height*0.15)
                    
                Image("cancel")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width*1.2)
                .position(x: geometry.size.width*0.38, y: geometry.size.height*0.45)
        }
        }.onAppear(){
            showRecap = false
        }
    }
}

//struct BigliettononvalidoView_Previews: PreviewProvider {
//    static var previews: some View {
//        BigliettoNonValido()
//    }
//}
