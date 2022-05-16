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
struct TestDownloadImage: View {
    @State var eventModel : EventModel = EventModel()
    @State var event = Event()
    @State var name:String = ""
    @State var mappa:String = ""
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
                
             
                Image(uiImage: image )
                    .frame(width: 100, height: 100, alignment: .center)
            }
        }
    } }

