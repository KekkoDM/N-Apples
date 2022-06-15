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
    @State var intero: Int = 0
    @State var openAlert: Bool = false
    @Binding var indici:[Int]

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
                
                
                ZStack {
                    
                    
                    Color(red: 11/255, green: 41/255, blue: 111/255)
                        .ignoresSafeArea()
                    
                    ScrollView( showsIndicators: false){
                        
                        VStack(alignment: .leading , spacing: 30 ){
                            
                            
                            EventNameField(eventName: $name)
                            
                            LocationField(eventLocation: $location)
                            
                            PickersView(birthDate: $timePrices[0])
                                
                            AvailableReservationField(availableReservation: $capability)
                               
                            eventDescriptionField(eventDescription: $info)
                            
                            addPricesView(timePrices: $timePrices, prices: $prices, tables: $tables)
                                .padding(.top, 50)
                            if timePrices.count > 1 {
                                
                            ForEach( 2 ..< timePrices.count, id: \.self){ int in
                                
                                if (int % 2 == 0) {

                                    priceCard(orariocard: $timePrices[int-1], orariocardfine: $timePrices[int], prezzocard: $prices[int], tables: $tables[int])
                                        .onLongPressGesture {
                                            intero = int
                                            openAlert.toggle()
                                            
                                        }

                                    .frame(width: geometry.size.width * 0.92, height:geometry.size.height * 0.1)
                                }
                                
                            }
                                
                            }
                            
                        }
                        .padding()
                        
                        
                        .navigationBarItems(leading:Button(action: { presentationMode.wrappedValue.dismiss()}) {
                            Text("Cancel").fontWeight(.bold)
                        } ,
                                            trailing:Button(action: {
                            Task {
  
                                indici.append(indici.count + 1)

                                pushNotification.subscribeEvent(textType: "Event")
                                try await eventModel.insertEvent(name: name, address: address, location: location, info: info, capability: Int(capability) ?? 0, date: dateEvents, timeForPrice: timePrices, price: prices.map{Int($0) ?? 0}, table: tables.map{String($0)})
                                 
                                presentationMode.wrappedValue.dismiss()
                               
                            }
                            
                        }) {
                            Text("Save").fontWeight(.bold)
                            
                            if(openAlert){
                                AlertCancelPrice(show: $openAlert, timePrices: $timePrices, prices: $prices, intero: $intero)
                            }
                            
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
            .foregroundColor(.white).font(.system(size: 21))
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
            .foregroundColor(.white).font(.system(size: 21))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white, lineWidth: 3)
            )
    }
}

struct eventDescriptionField: View {
    @Binding var eventDescription : String
    var body: some View {
        GeometryReader{ geometry in
            TextField("Event description", text: $eventDescription)
                .foregroundColor(.white).font(.system(size: 21))
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white, lineWidth: 3)
                )
        }
    }
}

struct addPricesView: View {
    @Binding var timePrices: [Date]
    @Binding var prices: [String]
    @Binding var tables: [String]
    var body: some View {
        
        HStack{
            
            Text("Prices")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            NavigationLink(destination: insertPriceView(timePrices: $timePrices, prices: $prices, tables: $tables)) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.orange)
            }
            
        }
        
    }
}

struct priceCard : View {

    @Binding var orariocard : Date
    @Binding var orariocardfine : Date
    
    @Binding var prezzocard : String
    @Binding var tables: String
    var body : some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
            HStack {
                VStack(alignment:.leading){
                    Text(tables)
                        .fontWeight(.bold)
                    Text("\(formattedDate(date:orariocard,format: "HH:mm")) - \(formattedDate(date:orariocardfine,format: "HH:mm"))")
                }
                Spacer()
                Text(prezzocard)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.black)
            .padding(.horizontal)
        }
    }
    func formattedDate(date:Date,format:String)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: date)
    }
}
