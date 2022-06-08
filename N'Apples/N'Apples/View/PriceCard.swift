//
//  PriceCard.swift
//  napples
//
//  Created by Gabriele Iorio on 03/06/22.
//

import SwiftUI

struct TextFieldAnimation: View {
    @Binding var name:String
    @State private var isEditingName = false
    var body: some View {
        VStack (alignment: .leading){
            Text("Event name").foregroundColor(.white)
               
                .fontWeight(.semibold)
                .scaleEffect((self.name == "" && self.isEditingName == false) ? 1 : 0.75)
                .offset( y: (self.name == "" && self.isEditingName == false ) ? 48 : 0)
                .offset( x: (self.name == "" && self.isEditingName == false ) ? 0 : -15)
                .padding(.leading)
                .animation(.spring())
               
            TextField("", text: $name )
                .foregroundColor(.white)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white, lineWidth: 3)
                )
        }
        
            .onTapGesture {
                self.isEditingName.toggle()
                if(self.isEditingName == false){
                    UIApplication.shared.endEditing()
                }
        }
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

