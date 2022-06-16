//
//  BigliettoValido.swift
//  N'Apples
//
//  Created by Simona Ettari on 14/06/22.
//

import Foundation
import SwiftUI

struct BigliettoValido: View {
    
//    struct ParametriBiglietto:Identifiable {
//        var id: String {
//            self.nome
//        }
//        @Binding var nome: String
//        @Binding var cognome: String
//        @Binding var numeropersone: Int
//        @Binding var nomepr: String
//        @Binding var email: String
    @Binding var reservation : Reservation
    @Binding var viewModel:ScannerViewModel
    @State var numScan:Int = 0
    @State var disable = false
    @State var nome = ""
    @State var cognome = ""
    @State var email = ""
    @State var numFriends = 0
    @State var list = ""
//    }
    
//    @State var Biglietto: [ParametriBiglietto] = [ParametriBiglietto(nome: "Domenico", cognome: "sdnsidn", numeropersone: 6, nomepr: "Nicola",email: "dom@gmail.com")]
    
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
                
//                ForEach(Biglietto){ index in
                    VStack(alignment: .leading, spacing: 12){
                        Text("Booked by")
                            .underline()
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("\(nome)  \(cognome ?? "")")
                            .font(.title2)
                           
                        Text("N° of people invited")
                            .font(.headline)
                            .underline()
                            .foregroundColor(.gray)
                        
                        Text("\( numScan)/\(numFriends )")
                            .font(.title2)
                            
                        Text("Promoter")
                            .underline()
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("\(list )")
                            .font(.title2)
                            
                        Text("E-mail")
                            .underline()
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("\(email )")
                            
                            .font(.title2)
                        Button(action: {
                            Task{
                                numScan = numScan + 1
                            disable = try await reservationModel.updateNumScan(id: viewModel.lastQrCode, numscan: numScan)

                                numScan = reservationModel.reservation.first!.numScan

                            }
                            disable = true

                        }) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color.blue)
                                    
                                    .frame(width: 300, height: 50, alignment: .center)
                                Text( "Add Ingress")
                                    .foregroundColor(Color.white)
                            }
                        }.disabled(disable)
                    }
                    
                    
                    .foregroundColor(.white)
                    .position(x: geometry.size.width*0.28, y: geometry.size.height*0.42)
                 
//                }
                
                
            }
        }.onAppear{
            numScan = reservationModel.reservation.first!.numScan
          nome = reservationModel.reservation.first!.name
         cognome = reservationModel.reservation.first!.surname
       email = reservationModel.reservation.first!.email
           numFriends = reservationModel.reservation.first!.numFriends
         list = reservationModel.reservation.first!.nameList
        }
    }
}

//struct BigliettovalidoView_Previews: PreviewProvider {
//    static var previews: some View {
//        BigliettoValido()
//    }
//}

