//
//  CreaEvento.swift
//  N'Apples
//
//  Created by Simona Ettari on 10/05/22.
//

import Foundation
import SwiftUI
import PassKit

struct EditView: View {
    
    
    @State  var address: String = ""
    @State var timePrices: [Date] = [Date()]
    
    @State  var tables: [String] = [""]
    @State var eventModel : EventModel = EventModel()
    @State var isPresenting: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var pushNotification: CloudkitPushNotificationViewModel = CloudkitPushNotificationViewModel()
    
    @Binding var ParamentriRecap: ParametriRiepilogo
    
    
    
    @Environment(\.presentationMode) var presentationMode
    @State  var eventName : String = ""
    @State private var eventLocation : String = ""
    @State private var availableReservation : String = ""
    @State private var eventDescription : String = ""
    
    @State var presentIMieiEventi: Bool = false
    
    
    var body: some View {
        
        
        NavigationView{
        
        
        GeometryReader{geometry in
            
            
            ZStack{
                
                
                Color(red: 11/255, green: 41/255, blue: 111/255)
                    .ignoresSafeArea()
                
                ScrollView( showsIndicators: false){
                    
                    VStack(alignment: .leading , spacing: 20 ){
                        
                        
                        TextFieldAnimation(name: $ParamentriRecap.titoloEvento)
                        
                        LocationFieldAnimation(nameLocation:$ParamentriRecap.location)
                        
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height *  0.2)
                        
                        
                        PickersView(birthDate: $ParamentriRecap.data[0])
                            .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.2)
                        
                        
                        AvailableAnimation(nameAvailable: $ParamentriRecap.prenotazioniDisponibili)
                            .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.2)
                        
                        
                        EventDescriptionAnimation(nameDescription: $ParamentriRecap.descrizioneEvento)
                            .foregroundColor(.gray).font(.system(size: 21))
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height *  0.2)
                            .overlay(RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.white, lineWidth: 3)
                            )
                        
                        addPricesView(timePrices: $ParamentriRecap.data, prices: $ParamentriRecap.tariffeEntrata)
                        ForEach( 0..<$ParamentriRecap.data.count, id: \.self){ i in
                            
                            Text("\(formattedDate(date:ParamentriRecap.data[i],format: "HH:mm"))")
                               
                            DatePicker(selection: $ParamentriRecap.data[i], displayedComponents:.hourAndMinute, label: {
                                Text("Time for prices")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            })
                            TextField("prices", text:$ParamentriRecap.tariffeEntrata[i])
                        }.onAppear{
                            print("ON APPERA COUNT DATA \(ParamentriRecap.data.count)")
                        }
                        
                    }
                    .padding()
                    
                    
                    //                        .position(x: geometry.size.width*0.55, y: geometry.size.height*0.1)
                    
//                    .navigationBarItems(
//                        trailing:Button(action: {
//                            Task {
//                                pushNotification.subscribeEvent(textType: "Event")
//
//                                try await eventModel.update(idEvent: ParamentriRecap.idEvent, name: ParamentriRecap.titoloEvento, address: ParamentriRecap.location, location: ParamentriRecap.location, info:  ParamentriRecap.descrizioneEvento,  capability: Int(ParamentriRecap.prenotazioniDisponibili) ?? 0, date: ParamentriRecap.data.first!, lists: [], table: [], price: ParamentriRecap.tariffeEntrata.map{Int($0) ?? 0}, timeForPrice: ParamentriRecap.data)
//                            }
//
//                        }) {
//                            Text("Save").fontWeight(.bold)
//
//                            NavigationLink (destination: EventView(eventModel: eventModel, roleModel: roleModel), isActive: $presentIMieiEventi) {
//                                //                                Text("Save").fontWeight(.bold)
//
//
//
//                            }
//                            .disabled(eventName.isEmpty)
//                        } )
            
                    
                            .navigationBarItems(leading:Button(action: { presentationMode.wrappedValue.dismiss()}) {
                                Text("Cancel").fontWeight(.bold)
                            } ,
                                                trailing:Button(action: {
                                Task {
                                    pushNotification.subscribeEvent(textType: "Event")
                                    try await eventModel.update(idEvent: ParamentriRecap.idEvent, name: ParamentriRecap.titoloEvento, address: ParamentriRecap.location, location: ParamentriRecap.location, info:  ParamentriRecap.descrizioneEvento,  capability: Int(ParamentriRecap.prenotazioniDisponibili) ?? 0, date: ParamentriRecap.data.first!, lists: [], table: [], price: ParamentriRecap.tariffeEntrata.map{Int($0) ?? 0}, timeForPrice: ParamentriRecap.data)

                                    presentationMode.wrappedValue.dismiss()
        //                                showEvents = true

                                }

                            }) {
                                Text("Save").fontWeight(.bold)

                                NavigationLink (destination: EventView(eventModel: eventModel, roleModel: roleModel), isActive: $presentIMieiEventi) {
        //                                Text("Save").fontWeight(.bold)



                                }
                                                                .disabled(eventName.isEmpty)
                            } )
                }
                
            }
            
            
        }
        .navigationTitle("Edit Event")
        .navigationBarTitleDisplayMode(.automatic)
        
        
        }
    }
    
    func formattedDate(date:Date,format:String)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: date)
    }
    
}

