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
    var reservationModel : ReservationModel = ReservationModel()
    @State var reservation = Reservation()
    @State var showRecap: Bool = false
    var body: some View {
        ZStack { Color.red
            VStack {
                if(showRecap){
                    Text("Name: " + reservation.name)
                    Text("Surname: " + reservation.surname)
                    Text("Email: " + reservation.email)
                    Text("List: " + reservation.nameList)
                    Text("Entrance: \(reservation.numScan)/\(reservation.numFriends)")
                    Button (action: {
                        Task {
                            try await reservationModel.retrieveAllId(id: viewModel.lastQrCode)
                            
                            reservation = reservationModel.reservation.first!
                            
                            try await reservationModel.update(reservation1: reservation, id: reservation.id ,name: reservation.name, surname: reservation.surname, email: reservation.email, nameList: reservation.nameList, timeScan: Date(), numFriends: reservation.numFriends, numScan: reservation.numScan + 1)
                            
                            reservation = reservationModel.reservation.first!
                        }
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color.blue)
                                .frame(width: 300, height: 50, alignment: .center)
                            Text( "Add Ingress")
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
            
        }.onAppear(){
            
            Task {
                try await reservationModel.retrieveAllId(id: viewModel.lastQrCode)
                
                reservation = reservationModel.reservation.first!
                
                try await reservationModel.update(reservation1: reservation, id: reservation.id ,name: reservation.name, surname: reservation.surname, email: reservation.email, nameList: reservation.nameList, timeScan: Date(), numFriends: reservation.numFriends, numScan: reservation.numScan + 1)
                
                reservation = reservationModel.reservation.first!
                
                showRecap.toggle()
            }
        }
    }
    
}
