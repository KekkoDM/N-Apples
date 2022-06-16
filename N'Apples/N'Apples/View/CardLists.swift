//
//  CardLists.swift
//  N'Apples
//
//  Created by Simona Ettari on 08/06/22.
//

import Foundation
import SwiftUI


struct CardLists: View {
@Binding var i:Int
    let geometry: GeometryProxy
    struct Card:Identifiable {
        var id: String {
            self.nameCollaboratore }
        var nameCollaboratore: String
        var surnameCollaboratore: String
        var personeInLista: Int
    }
    @State var CardPrenotati: [Card] = [Card(nameCollaboratore:"Nicola",surnameCollaboratore:"d'abrosca",personeInLista: 100)]
    
    var body: some View {
        //        GeometryReader{
        
        //            geometry in
        //            ScrollView{
        ForEach(0 ..< reservationModel.reservation.count, id: \.self) { n in
            
           
            HStack{
                
                Text("\(reservationModel.reservation[n].name) \(reservationModel.reservation[n].surname)")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                
                
                Divider().background(.white)
                    .frame(width: geometry.size.width * 0, height: geometry.size.width * 0.15)
                    .padding(.horizontal, geometry.size.width * 0.07)
                
                
                Text("\(reservationModel.reservation[n].numScan) / \(reservationModel.reservation[n].numFriends)")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                
                
            }
            
            .frame(width: geometry.size.width*0.90, height: geometry.size.height*0.11)
            .background(Color(red: 0.19, green: 0.28, blue: 0.51))
            .cornerRadius(10, corners: [.topLeft, .bottomRight])
            .shadow(radius: 2, y: 2)
        }
        //            }
        
        //        }
        
    }
}
