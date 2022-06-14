//
//  ScannerView.swift
//  Qr
//
//  Created by Nicola D'Abrosca on 10/05/22.
//

import SwiftUI

var backToContent = false

struct ScannerView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    
    var body: some View {
        
        ZStack {
            QrCodeScannerView()
                .found(r: self.viewModel.onFoundQrCode)
                .torchLight(isOn: self.viewModel.torchIsOn)
                .interval(delay: self.viewModel.scanInterval)
            
            
            VStack {
                HStack {
                    //                        Text(self.viewModel.lastQrCode)
                    //                            .bold()
                    //                            .lineLimit(5)
                    //                            .padding()
                    Spacer()
                    
                    //                            Button(action: {
                    //                                self.viewModel.torchIsOn.toggle()
                    //                            }, label: {
                    //                                Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                    //                                    .imageScale(.large)
                    //                                    .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.blue)
                    //                                    .padding(7)
                    //                            })
                    //                        .background(Color.white)
                    //                        .cornerRadius(10)
                }.padding(.horizontal)
                    .padding(.vertical, 50)
                
                Spacer()
                
                Text("Keep scanning for QR-codes")
                    .font(.subheadline)
            }                            .padding(.bottom, 25)
            
            
            
            
            
            
            if(backToContent){
                RecapView(viewModel: viewModel)
            }
        }.ignoresSafeArea(.all)
            .navigationBarItems(trailing:
                Button(action: {
                self.viewModel.torchIsOn.toggle()
            }, label: {
                VStack{
                Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                    .imageScale(.large)
                    .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.blue)
                    .padding(7)
                }.background(Color.white)
                    .cornerRadius(10)
            }))
        
        
        
    }
}
