//
//  RecapView.swift
//  Qr
//
//  Created by Francesco on 11/05/22.
//

import Foundation
import SwiftUI

struct RecapView: View {
    
    @State var viewModel: ScannerViewModel
    @State var reservation = Reservation()
    @State var showRecap: Bool = false
    @State var ingress = 1
    @State var numScan = 0
    @State var stringaGif: String = "LoadingGif"
    @State var flag: Bool = true
    @State var nonValido: Bool = false

    var body: some View {
        
        GeometryReader {
            geometry in
        ZStack {
            VStack {
                if(showRecap) {
                    NavigationLink(destination: BigliettoValido(reservation: $reservation, viewModel: $viewModel, showRecap: $showRecap), isActive: $showRecap){}.onAppear{
                        flag = false
                        
                      
                    }
                }
                if (nonValido){
                    
                    NavigationLink(destination: BigliettoNonValido(showRecap: $showRecap), isActive: $nonValido){}.onAppear{
                        print("NON VAL: \(nonValido)")
                        flag = false
                        print("SEEEEEIII")
                    }
                }
//                    NavigationLink (destination: GifFile(eventModel: eventModel, roleModel: roleModel, indici: $indici), isActive: $presentIMieiEventi) {
//                       
//                    }
//                        .padding(.leading,100)
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
                    
                
//                else {
//                    BigliettoNonValido()
//                    GifImage(stringaGif)
//
//                                         .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
//                                         .padding(.top, 200)
//
//                                         .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.45)
//                                         .background( Color(red: 11/255, green: 41/255, blue: 111/255))
//                }
            }
            
        }
        .background(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
        .fullScreenCover(isPresented: $flag, content: {
            VStack{
            GifImage(stringaGif)
            
                .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7, alignment: .center)
                .padding(.top, 200)

                .position(x: geometry.size.width * 0.68, y: geometry.size.height*0.45)
                .background( Color(red: 11/255, green: 41/255, blue: 111/255))
            
}})
        .onAppear() {
            reservationModel.records.removeAll()
            reservationModel.reservation.removeAll()
            print("Reserv: \(reservationModel.reservation)")
            print("shoW: \(showRecap)")
            print("nonv: \(nonValido)")
            

            Task {
                
//                try await reservationModel.retrieveAllId(id: viewModel.lastQrCode)
//                reservationModel.records.removeAll()
//                reservationModel.reservation.removeAll()
                
                
                try await reservationModel.updateNumScan(id: viewModel.lastQrCode, numscan: numScan)
                viewModel = ScannerViewModel()
//                reservation = reservationModel.reservation.first!
                print("A MAronn t' accupagn \(reservationModel.reservation)")
                print("A MAronn t' accupagn \(viewModel.lastQrCode)")

                if(!reservationModel.records.isEmpty){
                    showRecap.toggle()
                    
                } else {
                    viewModel = ScannerViewModel()
                    nonValido.toggle()
                }
                
//                if (!showRecap) {
//
//                    nonValido = true
//                    print("TRUE\(nonValido)")
//                }
                
            }
        }
        }}
    
}
