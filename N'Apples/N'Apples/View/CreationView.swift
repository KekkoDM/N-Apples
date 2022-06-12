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
    @State var eventModel : EventModel = EventModel()
    @State var isPresenting: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var pushNotification: CloudkitPushNotificationViewModel = CloudkitPushNotificationViewModel()
    
    
    @Environment(\.presentationMode) var presentationMode
    @State  var eventName : String = ""
    @State private var eventLocation : String = ""
    @State private var availableReservation : String = ""
    @State private var eventDescription : String = ""
    
    @State var presentIMieiEventi: Bool = false
    
    
    var body: some View {
        
        //        NavigationView {
        //            ScrollView {
        //                ZStack {
        //                    VStack {
        //                        ZStack {
        //                            VStack {
        //                                Text("Create Events")
        //                                TextField("Name", text: $name)
        //                                TextField("Location", text: $location)
        //                                TextField("Address", text: $address)
        //                                TextField("info", text: $info)
        //
        //                            }
        //                        }
        //
        //                        TextField("Capability", text: $capability)
        //
        //                        Text("\(formattedDate(date:dateEvents,format: "dd/MM HH:mm"))")
        //                        DatePicker(selection: $dateEvents, displayedComponents:.date, label: {
        //                            Text("Date")
        //                                .fontWeight(.bold)
        //                                .foregroundColor(.black)
        //                        })
        //                        VStack{
        //                            Button(action: {
        //                                isPresenting.toggle()
        //
        //                            }, label: {Text("Add Image")
        //                                Image(uiImage: image ?? UIImage())
        //                                    .resizable()
        //                                    .frame(width: 200, height: 200, alignment: .center)
        //                            })
        //
        //                        }
        //                        Button(action: {
        //                            timePrices.append(timePrices[0])
        //                            prices.append(prices[0])
        //                        }, label: {Text("Add Hour")})
        //
        //
        //                        ForEach( 0..<timePrices.count, id: \.self){ i in
        //                            Text("\(formattedDate(date:timePrices[i],format: "HH:mm"))")
        //                            DatePicker(selection: $timePrices[i], displayedComponents:.hourAndMinute, label: {
        //                                Text("Time for prices")
        //                                    .fontWeight(.bold)
        //                                    .foregroundColor(.black)
        //                            })
        //                            TextField("prices", text:$prices[i])
        //                        }
        //
        //                        Button(action: {
        //                            tables.append(tables[0])
        //                        }, label: {Text("Add Table")})
        //
        //
        //                        ForEach( 0..<tables.count, id: \.self){ i in
        //                            TextField("Tables", text:$tables[i])
        //                        }
        //
        //                        Button(action: {
        //                            Task{
        //                                pushNotification.subscribeEvent(textType: "Event")
        //                                try await eventModel.insertEvent(name: name, address: address, location: location, info: info, imagePoster: image, capability: Int(capability) ?? 0, date: dateEvents, timeForPrice: timePrices, price: prices.map{Int($0) ?? 0}, table: tables)
        //                            }
        //                        }, label: {
        //                            ZStack {
        //                                RoundedRectangle(cornerRadius: 25)
        //                                    .foregroundColor(.blue)
        //                                    .frame(width: 200, height: 100, alignment: .center)
        //                                Text("Insert Events")
        //                                    .foregroundColor(.white)
        //                            }.padding(.bottom, 40)
        //                        })
        //
        //                    }
        //                    .fullScreenCover(isPresented: $isPresenting){
        //                        ImagePicker(uiImage: $image, isPresenting:  $isPresenting, sourceType: $sourceType)}
        //                }
        //            }
        //        }
        
        
        
        NavigationView {
            
            GeometryReader{geometry in
                
                
                ZStack{
                    
                    
                    Color(red: 11/255, green: 41/255, blue: 111/255)
                        .ignoresSafeArea()
                    
                    ScrollView( showsIndicators: false){
                        
                        VStack(alignment: .leading , spacing: 20 ){
                            
                            
                            TextFieldAnimation(name: $name)
                            
                            LocationFieldAnimation(nameLocation:$location)
                            
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height *  0.2)
                            
                            
                            PickersView(birthDate: $timePrices[0])
                                .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.2)
                            
                            
                            AvailableAnimation(nameAvailable: $capability)
                                .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.2)
                            
                            
                            EventDescriptionAnimation(nameDescription: $info)
                                .foregroundColor(.gray).font(.system(size: 21))
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height *  0.2)
                                .overlay(RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.white, lineWidth: 3)
                                )
                            
                            addPricesView(timePrices: $timePrices, prices: $prices)
                            ForEach( 1..<timePrices.count, id: \.self){ i in
                                Text("\(formattedDate(date:timePrices[i],format: "HH:mm"))")
                                DatePicker(selection: $timePrices[i], displayedComponents:.hourAndMinute, label: {
                                    Text("Time for prices")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                })
                                TextField("prices", text:$prices[i])
                            }
                            
                        }
                        .padding()
                        
                        
                        //                        .position(x: geometry.size.width*0.55, y: geometry.size.height*0.1)
                        
                        .navigationBarItems(leading:Button(action: { presentationMode.wrappedValue.dismiss()}) {
                            Text("Cancel").fontWeight(.bold)
                        } ,
                                            trailing:Button(action: {
                            Task {
                                pushNotification.subscribeEvent(textType: "Event")
                                try await eventModel.insertEvent(name: name, address: address, location: location, info: info, capability: Int(capability) ?? 0, date: dateEvents, timeForPrice: timePrices, price: prices.map{Int($0) ?? 0}, table: tables)
                                
                                presentationMode.wrappedValue.dismiss()
                               
                            }
                            
                        }) {
                            Text("Save").fontWeight(.bold)
                            
                            NavigationLink (destination: EventView(eventModel: eventModel, roleModel: roleModel), isActive: $presentIMieiEventi) {
                               
                            }
                            .disabled(eventName.isEmpty)
                        } )
                    }
                }
                
                
            }
            .navigationTitle("New event")
            .navigationBarTitleDisplayMode(.automatic)
        }
        
        
    }
    
    func formattedDate(date:Date,format:String)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: date)
    }
    
}


struct EventNameField: View {
    @Binding var eventName : String
    var body: some View {
        TextField("Event name", text: $eventName)
            .foregroundColor(.white).font(.system(size: 21))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white, lineWidth: 3)
            )
    }
}

struct LocationField: View {
    @Binding var eventLocation : String
    var body: some View {
        TextField("Location", text: $eventLocation)
            .foregroundColor(.gray).font(.system(size: 21))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white, lineWidth: 3)
            )
    }
}

struct AvailableReservationField: View {
    @Binding var availableReservation : String
    var body: some View {
        TextField("Available reservation", text: $availableReservation)
            .foregroundColor(.gray).font(.system(size: 21))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white, lineWidth: 3)
            )
    }
}
