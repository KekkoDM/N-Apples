//
//  insertPriceView.swift
//  napples
//
//  Created by Gabriele Iorio on 01/06/22.
//

import SwiftUI

struct insertPriceView: View {
    @Environment(\.presentationMode) var presentationMode
//    init() {
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//    }
    @State private var typology : String = ""
    @State private var priceDescription : String = ""
    @State private var priceAddition : String = ""
    @State private var priceDate = Date()
    @State private var priceTime = Date()
    @State private var priceStartTime = Date()
    @State private var priceEndTime = Date()
    @Binding var timePrices: [Date]
    @Binding var prices: [String]
    @Binding var tables: [String]
 
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 11/255, green: 41/255, blue: 111/255)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading , spacing: 20 ){
                    
                    
                    TextField("Typology", text: $typology)
                        .padding()
                        .foregroundColor(.white).font(.system(size: 21))
                        .overlay(RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.white, lineWidth: 3)
                        )
                        .frame(width: geometry.size.width*0.7, height: geometry.size.height*0.1)
                    
                    
                    TextField("Price", text: $priceAddition)
                        .padding()
                        .foregroundColor(.white).font(.system(size: 21))
                        .overlay(RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.white, lineWidth: 3)
                        )
                        .frame(width: geometry.size.width*0.4, height: geometry.size.height*0.1)
                    
                    
                    Text("Time Slot").fontWeight(.bold).font(.system(size: 20)).foregroundColor(.white)
                        .padding(.vertical)
                    
                    
                    pricePicker(priceStartTime: $priceStartTime, priceEndTime: $priceEndTime)
                        .padding(.top)
                    
                    
  
                }
                .padding()
                
                
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    
                    Image(systemName: "chevron.backward")
                        .font(Font.subheadline.weight(.bold))

                } )
                .navigationBarItems(trailing: Button(action: {
                    
                    tables.append(typology)
                    tables.append(typology)
                    prices.append(priceAddition)
                    prices.append(priceAddition)
                    timePrices.append(priceStartTime)
                    timePrices.append(priceEndTime)
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                   
                    Text("Add")
                        .fontWeight(.bold)
                })
                
               
                
                
                
                
                

                
            } // FINE ZSTACK DELLO SFONDO
            
            
        } // FINE DEL GEOMETRY READER
        
       
        
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("Prices")
        .navigationBarTitleDisplayMode(.inline)
    } // FINE DEL BODY
} // FINE DEL MAIN





