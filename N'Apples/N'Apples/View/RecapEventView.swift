//
//  RecapEventView.swift
//  N'Apples
//
//  Created by Simona Ettari on 24/05/22.
//

import Foundation
import SwiftUI 

struct RecapEventView: View {
    @Binding var eventModel: EventModel
    @State var reservationModel = ReservationModel()
    @Binding var i: Int
    @State var presentRoleView: Bool = false
    @State var presentReservationView: Bool = false
    @State var showReservation = false
    @State var showScannerView = false
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack{
                    Text("Event: " + eventModel.event[i].name)
                }
                
                if(roleModel.role[i].permission == [0, 0, 0]){
                    Text("Partecipants")
                        .padding()
                    if(showReservation){
                        ForEach(0 ..< reservationModel.reservation.count, id: \.self) { i in
                            Text("Person \(i+1)").foregroundColor(.red)
                            
                            HStack{
                                Text("Name: " + reservationModel.reservation[i].name + " " + reservationModel.reservation[i].surname)
                            }
                            
                            HStack{
                                Text("E-Mail: " + reservationModel.reservation[i].email)
                            }
                            
                            HStack{
                                Text("List: " + reservationModel.reservation[i].nameList)
                            }
                            
                            HStack{
                                Text("Qr Scanned: \(reservationModel.reservation[i].numScan)/\(reservationModel.reservation[i].numFriends)")
                            }
                            
                            Spacer()
                        }
                    }
                    
                    
                    
                    NavigationLink (destination: RoleView(i: $i, eventModel: $eventModel), isActive: $presentRoleView) {
                        
                        Text("Role")
                            .onTapGesture {
                                presentRoleView.toggle()
                            }
                    }
                    
                }
                
                if(roleModel.role[i].permission[0] == 1){
                    NavigationLink (destination: ScannerView(), isActive: $showScannerView) {
                        Text("Scanner Qr")
                            .onTapGesture {
                                showScannerView.toggle()
                            }
                    }
                }
                
                if((roleModel.role[i].permission.count > 1) && (roleModel.role[i].permission[1] == 1)){
                    NavigationLink (destination: ReservationView (event: eventModel.event[i]), isActive: $presentReservationView) {
                        Text("Reservation")
                            .onTapGesture {
                                presentReservationView.toggle()
                            }
                    }
                }
                
                
                
                
                
            }
        }.onAppear() {
            Task {
                try await roleModel.retrieveAllCollaborators(idEvent: eventModel.event[i].id)
                try await reservationModel.retrieveAllEventIdDecrypt(idEvent: eventModel.event[i].id)
                if(!reservationModel.reservation.isEmpty){
                    showReservation = true
                }
                
            }
        }
    }
}
