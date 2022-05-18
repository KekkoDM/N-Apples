//
//  CreaEvento.swift
//  N'Apples
//
//  Created by Simona Ettari on 10/05/22.
//

import Foundation
import SwiftUI
import PassKit

struct CreationView: View {
 
    @State var name: String = ""
    @State var location: String = ""
    @State var address: String = ""
    @State var info: String = ""
    @State var capability: String = ""
    @State var dateEvents: Date = Date()
    @State var timePrices: [Date] = [Date()]
    @State var prices: [String] = [""]
    @State var tables: [String] = [""]
    @State var image:UIImage?
    @State var eventModel : EventModel = EventModel()
    @State var isPresenting: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        
        NavigationView{
            ZStack{
                VStack{
                    ZStack{
                        VStack{
                            Text("Create Events")
                            TextField("Name", text: $name)
                            TextField("Location", text: $location)
                            TextField("Address", text: $address)
                            TextField("info", text: $info)
                            
                        }
                    }
                    
                    TextField("Capability", text: $capability)
                    //                    TextField("Poster", text: $poster)
                    
                    Text("\(formattedDate(date:dateEvents,format: "dd/MM HH:mm"))")
                    DatePicker(selection: $dateEvents, displayedComponents:.date, label: {
                        Text("Date")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    })
                    VStack{
                    Button(action: {
                        
//                        image = UIImage(named: "Giorgio.jpeg") ?? UIImage()
                        isPresenting.toggle()

                    }, label: {Text("Add Image")
                        Image(uiImage: image ?? UIImage())
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                    })
                    
                    }
                    Button(action: {
                        timePrices.append(timePrices[0])
                        prices.append(prices[0])
                    }, label: {Text("Add Hour")})
                    
                    
                    ForEach( 0..<timePrices.count, id: \.self){ i in
                        Text("\(formattedDate(date:timePrices[i],format: "HH:mm"))")
                        DatePicker(selection: $timePrices[i], displayedComponents:.hourAndMinute, label: {
                            Text("Time for prices")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        })
                        TextField("prices", text:$prices[i])
                    }
                    
                    Button(action: {
                        tables.append(tables[0])
                    }, label: {Text("Add Table")})
                    
                    
                    ForEach( 0..<tables.count, id: \.self){ i in
                        TextField("Tables", text:$tables[i])
                    }
                    
                    Button(action: {
                        Task{
                            try await eventModel.insertEvent(name: name, address: address, location: location, info: info, imagePoster: image, capability: Int(capability) ?? 0, date: dateEvents, timeForPrice: timePrices, price: prices.map{Int($0) ?? 0}, table: tables)
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.blue)
                                .frame(width: 200, height: 100, alignment: .center)
                            Text("Insert Events")
                                .foregroundColor(.white)
                        }.padding(.bottom, 40)
                    })
                    
                    
                    
             
                    
                }
                .fullScreenCover(isPresented: $isPresenting){
                    ImagePicker(uiImage: $image, isPresenting:  $isPresenting, sourceType: $sourceType)}
            }
            
        }}
    
    func formattedDate(date:Date,format:String)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: date)
    }
    
    
}

