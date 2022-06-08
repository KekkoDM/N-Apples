//
//  addPricesView.swift
//  napples
//
//  Created by Gabriele Iorio on 31/05/22.
//

import SwiftUI

struct addPricesView: View {
    var body: some View {
       
//        GeometryReader{geometry in
        HStack{
            
            Text("Prices")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .fontWeight(.semibold)
//            Spacer()
            
            NavigationLink(destination: insertPriceView()) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.orange)
            }
         
        }
//        .frame(width: geometry.size.width * 0.4, height: geometry.size.height *  0.1)

//        }
    }
}

struct addPricesView_Previews: PreviewProvider {
    static var previews: some View {
        addPricesView()
    }
}
