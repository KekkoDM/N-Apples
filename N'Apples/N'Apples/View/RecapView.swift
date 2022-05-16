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
//    var reservationModel : ReservationModel = ReservationModel()
    @State var reservation = Reservation()
    @State var showRecap: Bool = false
    @State var ingress = 1
    var body: some View {
        ZStack { Color.red
            VStack {
                if(showRecap){
                    Text("Name: " + reservationModel.reservation.first!.name)
                    Text("Surname: " + reservationModel.reservation.first!.surname)
                    Text("Email: " + reservationModel.reservation.first!.email)
                    Text("List: " + reservationModel.reservation.first!.nameList)
                    Text("Entrance: \(reservationModel.reservation.first!.numScan)/\(reservationModel.reservation.first!.numFriends)")
                   
                    Button(action: {
                      ingress = ingress + 1
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color.blue)
                                .frame(width: 300, height: 50, alignment: .center)
                            Text( "Ingress + 1 = \(ingress)")
                                .foregroundColor(Color.white)
                        }
                    }
                    
                    Button(action: {
                        Task{
                            
                            try await reservationModel.updatepzzot(at: 0, id: viewModel.lastQrCode)

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
            
        }
        .onAppear() {
            
            Task {
                
//                try await reservationModel.retrieveAllId(id: viewModel.lastQrCode)
                
//                print("MANNAGGIA CRISTO: \(reservationModel.reservation)")
                
                try await reservationModel.updatepzzot(at: 0, id: viewModel.lastQrCode)
                
//                reservation = reservationModel.reservation.first!
                
                showRecap.toggle()
            }
        }
    }
    
}
