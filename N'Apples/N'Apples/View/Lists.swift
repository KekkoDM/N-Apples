//
//  Lists.swift
//  N'Apples
//
//  Created by Simona Ettari on 08/06/22.
//

import Foundation
import SwiftUI

struct Lists: View {
    @State var searchText: String = ""
    var TuttiIPrenotati = [1, 2, 3]
    @Binding var idEv: String
    @State var contoPren: Int = 0
    @State var carta = 0
    var body: some View {
        
        GeometryReader{
            
            geometry in
            
  

                    ScrollView(showsIndicators: false){
                        
                        NavigationLink(destination: InsideList()){
                            
                            HStack(spacing: 0){
                                
                                Text("All the reservation")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width*0.40)
                                
                                Divider().background(.white)
                                    .frame(width: geometry.size.width * 0, height: geometry.size.width * 0.15)
                                    .padding(.horizontal, geometry.size.width * 0.07)
                                
                                
                                Text("\(contoPren)")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                                
                                
                            }
                            
                            .frame(width: geometry.size.width*0.90, height: geometry.size.height*0.11)
                            .background(Color(red: 0.19, green: 0.28, blue: 0.51))
                            .cornerRadius(10, corners: [.topLeft, .bottomRight])
                            .shadow(radius: 2, y: 2)
                            
                            
                        }
                        .padding(.top, geometry.size.height * 0.09)
                        
                        VStack(spacing: 10){
            
                            CardLists(i: $carta, geometry: geometry)
                            
                            
                        }
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255))
                    .navigationTitle("Liste")
                
        .onAppear() {
            Task {                print("prenotati:\(reservationModel.reservation.count )")
                try await reservationModel.retrieveAllEventIdDecrypt(idEvent: idEv)
                carta = reservationModel.reservation.count

                for i in 0 ..< reservationModel.reservation.count {
                    contoPren = contoPren + reservationModel.reservation[i].numFriends
                }
            }
        }
        }
        .searchable(text: $searchText)
        
    }
    
//    init() {
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//    }
    
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}



//struct Lists_Previews: PreviewProvider {
//    static var previews: some View {
//        Lists()
//    }
//}
