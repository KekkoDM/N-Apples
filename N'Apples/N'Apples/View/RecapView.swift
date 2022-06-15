//
//  RecapView.swift
//  Qr
//
//  Created by Francesco on 11/05/22.
//

import Foundation
import SwiftUI

struct RecapView: View {
    
    @State var viewModel:ScannerViewModel
    @State var reservation = Reservation()
    @State var showRecap: Bool = false
    @State var ingress = 1
    @State var numScan = 0
    var body: some View {
        ZStack {
            VStack {
                if(showRecap) {
                    
                    BigliettoValido(reservation: $reservation, viewModel: $viewModel)
                        .padding(.leading,100)
//                    Text("Name: " + reservationModel.reservation.first!.name)
//
//                    Text("Surname: " + reservationModel.reservation.first!.surname)
//                    Text("Email: " + reservationModel.reservation.first!.email)
//                    Text("List: " + reservationModel.reservation.first!.nameList)
//                    Text("Entrance: \(reservationModel.reservation.first!.numScan)/\(reservationModel.reservation.first!.numFriends)")
//
//                    Button(action: {
//                      ingress = ingress + 1
//                    }) {
//                        ZStack{
//                            RoundedRectangle(cornerRadius: 25)
//                                .foregroundColor(Color.blue)
//                                .frame(width: 300, height: 50, alignment: .center)
//                            Text("Ingress + 1 = \(ingress)")
//                                .foregroundColor(Color.white)
//                        }
//                    }
//
//                    Button(action: {
//                        Task{
//                            try await reservationModel.updateNumScan(id: viewModel.lastQrCode)
//                        }
//                    }) {
//                        ZStack{
//                            RoundedRectangle(cornerRadius: 25)
//                                .foregroundColor(Color.blue)
//                                .frame(width: 300, height: 50, alignment: .center)
//                            Text( "Add Ingress")
//                                .foregroundColor(Color.white)
//                        }
//                    }
                } else {
                    BigliettoNonValido()
                }
            }
            
        }
        .background(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
        
        .onAppear() {
            
            Task {
                
//                try await reservationModel.retrieveAllId(id: viewModel.lastQrCode)
                
                
                try await reservationModel.updateNumScan(id: viewModel.lastQrCode, numscan: numScan)
                
//                reservation = reservationModel.reservation.first!
                print("A MAronn t' accupagn \(reservationModel.reservation)")
                if(!reservationModel.records.isEmpty){
                    showRecap.toggle()
                }
                
            }
        }
    }
    
}
