//
//  pricePicker.swift
//  napples
//
//  Created by Gabriele Iorio on 02/06/22.
//

import SwiftUI

struct pricePicker: View {
    @Binding  var priceStartTime:Date
    @Binding  var priceEndTime:Date
    var body: some View {
        GeometryReader{ geometry in
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 3)
                
            VStack {
                HStack{
                    Text("Start Time").foregroundColor(.white)
                    DatePicker("", selection: $priceStartTime, displayedComponents: .hourAndMinute)
                
                }
                
                Divider().foregroundColor(.white)
                HStack{
                    Text("End Time").foregroundColor(.white)
                    DatePicker("", selection: $priceEndTime, displayedComponents: .hourAndMinute)
                }
                
                
            }
            .padding()
        }
        .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.2)
    }
    }
}


