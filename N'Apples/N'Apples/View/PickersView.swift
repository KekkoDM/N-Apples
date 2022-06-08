//
//  PickersView.swift
//  napples
//
//  Created by Gabriele Iorio on 31/05/22.
//

import SwiftUI

struct PickersView: View {
    @Binding var birthDate:Date
    
    var body: some View {
        
//        GeometryReader{ geometry in
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 3)
                
            VStack {
                HStack{
                    Text("Date").foregroundColor(.white)
                    DatePicker("", selection: $birthDate, displayedComponents: .date)
                
                }
                
                Divider().foregroundColor(.white)
                HStack{
                    Text("Time").foregroundColor(.white)
                    DatePicker("", selection: $birthDate, displayedComponents: .hourAndMinute)
                }
                
                
            }
            .padding()
        }
//        .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.2)
        
//        }
    }
}
