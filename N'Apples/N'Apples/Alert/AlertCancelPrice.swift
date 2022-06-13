//
//  AlertCancelPrice.swift
//  N'Apples
//
//  Created by Simona Ettari on 13/06/22.
//

import Foundation
import SwiftUI

struct AlertCancelPrice: View {
    
    @Binding var show: Bool
    @Binding var timePrices: [Date]
    @Binding var prices: [String]
    @Binding var intero: Int
    
    var body: some View{
        VStack{
            
        }.alert(NSLocalizedString("Delete", comment: ""), isPresented: $show, actions: {
            Button("Cancel", action: {showSaved = false })
            Button("Ok", action: {
                timePrices.remove(at: intero)
                timePrices.remove(at: intero-1)
                prices.remove(at: intero)
                prices.remove(at: intero-1)
            })
            }, message: {
              Text("Are you sure you want to delete this price?")
            }
        )
    }
}
