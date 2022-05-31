//
//  TestDownloadImage.swift
//  N'Apples
//
//  Created by Nicola D'Abrosca on 13/05/22.
//

import Foundation
import SwiftUI
import CloudKit
import CoreLocation
import PassKit

struct TestDownloadImage: View {
    
    @State var eventModel : EventModel = EventModel()
    @State var event = Event()
    @State var name:String = ""
    @State var mappa:String = ""
    @State var notification :Bool = false
    let amount = PKPaymentSummaryItem(label: "Amount", amount: NSDecimalNumber(string: "39"), type: .final)
    let tax = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "11"), type: .final)
    let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "50.00"), type: .final)
    let paymentHandler = PaymentHandler()

    @State var image:UIImage = UIImage()
    
    var body: some View {
        ZStack{Color.black
            VStack{
                Text("Test Download image")
                TextField("Name Event", text: $name)
                    .padding(.leading,50)
                Button(action: {
                    Task{
                        try await eventModel.retrieveAllName(name:name)
                        print(eventModel.event.first!)
                        let data = try? Data(contentsOf: (eventModel.event.first?.poster.fileURL!)!)
                        image = UIImage(data: data!)!
                    }
                }, label: {Text("Press Here")})
                
                TextField("Address", text: $mappa)
                    .padding(.leading,50)
                Button( action: {
                    let geocoder = CLGeocoder()
                    geocoder.geocodeAddressString("\(mappa)") {
                        placemarks, error in
                        let placemark = placemarks?.first
                        let lat = placemark?.location?.coordinate.latitude
                        let lon = placemark?.location?.coordinate.longitude
                        print("Lat: \(lat ?? 40.8525858), Lon: \(lon ?? 14.2515941)")
                        let url = URL(string: "maps://?saddr=&daddr=\(lat ?? 40.8525858),\(lon ?? 14.2515941)")
                        if UIApplication.shared.canOpenURL(url!) {
                            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                        }
                    }
                }, label: {Text("Open in maps")})
                
                Button(action: {notification = true }, label: {Text("View Notification")})


//                Button(action: {
//                          self.paymentHandler.startPayment { (success) in
//                              if success {
//                                  print("Success")
//                              } else {
//                                  print("Failed")
//                              }
//                          }
//                      }, label: {
//                          Text("PAY WITH  APPLE")
//                          .font(Font.custom("HelveticaNeue-Bold", size: 16))
//                          .padding(10)
//                          .foregroundColor(.white)
//                  })
                PaymentButton()
                    .frame(width: 228, height: 40, alignment: .center)
                    .onTapGesture {
                        paymentHandler.startPayment(paymentSummaryItems: [amount,tax,total])
                    }
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
            }

//            if notification == true {
//                CloudkitPushNotification()
//            }
            
        }
    }
    
    
}

