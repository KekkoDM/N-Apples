//
//  PriceCard.swift
//  napples
//
//  Created by Gabriele Iorio on 03/06/22.
//

import SwiftUI

struct AvailableAnimation: View {
    @Binding var nameAvailable:String
    @State private var isEditingAvailable = false
    var body: some View {
        VStack (alignment: .leading){
            Text("Available Reservations").foregroundColor(.white)
               
                .fontWeight(.semibold)
                .scaleEffect((self.nameAvailable == "" && self.isEditingAvailable == false) ? 1 : 0.75)
                .offset( y: (self.nameAvailable == "" && self.isEditingAvailable == false ) ? 48 : 0)
                .offset( x: (self.nameAvailable == "" && self.isEditingAvailable == false ) ? 0 : -15)
                .padding(.leading)
                .animation(.spring())
               
            TextField("", text: $nameAvailable )
                .foregroundColor(.white)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white, lineWidth: 3)
                )
        }
        
            .onTapGesture {
                self.isEditingAvailable.toggle()
                if(self.isEditingAvailable == false){
                    UIApplication.shared.endEditing()
                }
        }
    }
}
extension UIApplication {
    func AvailableEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



