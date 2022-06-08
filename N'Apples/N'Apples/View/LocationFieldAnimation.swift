//
//  PriceCard.swift
//  napples
//
//  Created by Gabriele Iorio on 03/06/22.
//

import SwiftUI

struct LocationFieldAnimation: View {
    @Binding var nameLocation:String
    @State private var isEditingLocation = false
    var body: some View {
        VStack (alignment: .leading){
            Text("Location").foregroundColor(.white)
               
                .fontWeight(.semibold)
                .scaleEffect((self.nameLocation == "" && self.isEditingLocation == false) ? 1 : 0.75)
                .offset( y: (self.nameLocation == "" && self.isEditingLocation == false ) ? 48 : 0)
                .offset( x: (self.nameLocation == "" && self.isEditingLocation == false ) ? 0 : -15)
                .padding(.leading)
                .animation(.spring())
               
            TextField("", text: $nameLocation )
                .foregroundColor(.white)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white, lineWidth: 3)
                )
        }
        
            .onTapGesture {
                self.isEditingLocation.toggle()
                if(self.isEditingLocation == false){
                    UIApplication.shared.endEditing()
                }
        }
    }
}
extension UIApplication {
    func locationEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


