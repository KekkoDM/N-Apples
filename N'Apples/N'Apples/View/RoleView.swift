//
//  RoleView.swift
//  N'Apples
//
//  Created by Simona Ettari on 24/05/22.
//

import Foundation
import SwiftUI


struct RoleView: View {
    
    @Binding var i: Int
    @Binding var eventModel: EventModel
    @State var users: UserModel = UserModel()
    @Binding var roleModel: RoleModel
    @State var presentAssignRoleView: Bool = false
    @State var userSeacrh: String = ""
    @State var showingAlertRole: Bool = false
    
    var body: some View {
        
        ZStack {
            Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                .ignoresSafeArea()
            VStack{
                VStack{
                    
                    VStack(spacing: 25.0){
                        
                        Text("Write the email of your collaborators")
                            .font(.title3)
                        
                        TextField("", text: $userSeacrh)
                            .placeholder(when: userSeacrh.isEmpty){
                                Text("Write email").foregroundColor(.init(red: 0.72, green: 0.75, blue: 0.79, opacity: 1.00))
                            }
                            .padding(7)
                            .padding(.horizontal, 25)
                            .foregroundColor(.init(red: 0.72, green: 0.75, blue: 0.79, opacity: 1.00))
                            .background(Color(red: 0.24, green: 0.30, blue: 0.59).opacity(0.9))
                        
                        
                            .cornerRadius(20)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.init(red: 0.72, green: 0.75, blue: 0.79, opacity: 1.00))
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 8)
                                })
                        
                        
                    }
                    .padding()
                    
                    
                    
                    Button {
                        
                        Task {
                            try await users.retrieveAllEmail(email: userSeacrh + " ")
                            
                            if (!users.user.isEmpty) {
                                
                                presentAssignRoleView.toggle()
                                
                            } else {
                                showingAlertRole.toggle()
                            }
                            
                        }
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 7)
                        
                            .foregroundColor(.orange)
                            .overlay(Text("Search")
                                .foregroundColor(.white))
                            .frame(width: 200, height: 50, alignment: .center)
                        
                            .padding()
                        
                        
                    }
                    
                    .onAppear() {
                        Task {
                            print("I in RoleView: \(i)")
                            try await userModel.retrieveAll()
                        }
                    }
                    
                    
                    .navigationTitle("Assign a Role")
                    .navigationBarTitleDisplayMode(.inline)
                    
                    
                }.background(Color(red: 0.19, green: 0.28, blue: 0.51)
                    .ignoresSafeArea())
                .cornerRadius(20)
                .padding()
                
                Text("ROLE RECAP")
                    .font(.title)
                    
                
                ScrollView {
                    VStack {
                        Spacer()
                        
                        Spacer()
                    }
                    Spacer()
                    VStack(spacing: 80.0){
                        ForEach(0 ..< roleModel.role.first!.permission.count, id: \.self) { i in
                            Divider()
                            
                            RuoliView(roleModel: $roleModel, Ruoli:[RuoliView.ParametriRuoli(ruolo: roleModel.role[i].permission.map{String($0) }, nome: roleModel.role[i].username, cognome: roleModel.role[i].username)])
                        }
                    }
                }
            }
        }
        
        .sheet(isPresented: $presentAssignRoleView) {
            AssignRoleView(eventModel: $eventModel, i: $i, users: $users)
        }
        
        
        
        if (showingAlertRole == true) {
            AlertRole(show: $showingAlertRole)
        }
        
        
        
        
    }
    
    
    
    
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

//    var searchResults: [String] {
//        if searchText.isEmpty {
//            return email
//        } else {
//            return email.filter { $0.contains(searchText) }
//        }
//    }


//        ZStack {
//            VStack {
//
//                HStack {
//                    TextField("Search", text: $userSeacrh)
//
//
//                    NavigationLink (destination: AssignRoleView(eventModel: $eventModel, i: $i, users: $users), isActive: $presentAssignRoleView) {
//
//                        Text("Search")
//                            .onTapGesture {
//                                Task {
//                                    try await users.retrieveAllEmail(email: userSeacrh)
//                                    print("EMAIL: " + userSeacrh)
//                                    if (!users.user.isEmpty){
//                                        print ("User Nicola: \(users.user.first!.username)")
//                                        presentAssignRoleView.toggle()
//                                    }
//
//                                }
//
//                            }
//
//                    }
//
//                }
//
//
//            }
//        }


struct RuoliView: View {
    
    @Binding var roleModel: RoleModel
    
    struct ParametriRuoli:Identifiable {
        var id: [String] {
            self.ruolo
            
        }
        var ruolo: [String]
        var nome: String
        var cognome: String
    }
    
    @State private var showingSheet = false
    @State var Ruoli: [ParametriRuoli] = [ParametriRuoli(ruolo: ["PR"], nome: "Domenico", cognome: "Marino")]
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack{
                
                Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                    .ignoresSafeArea()
                
                ForEach(Ruoli) {  index in
                    
                    
                    VStack(alignment: .leading,spacing: 15){
                        
                        Text("\(index.ruolo.description)")
                        
                            .font(.title)
                        
                        Button {
                            //           deve uscire la modale del profilo del tizio
                        } label: {
                            Rectangle()
                                .cornerRadius(10, corners: [.topLeft, .bottomRight])
                                .shadow(radius: 2, y: 2)
                                .foregroundColor(Color(red: 0.19, green: 0.28, blue: 0.51))
                                .overlay(Text("\(index.nome)  \(index.cognome)"))
                            
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.055)
                        }
                    }
                    .position(x: geometry.size.width*0.3, y: geometry.size.height*0.14)
                    
                    .foregroundColor(.white)
                }
                
                
            }
            
        }
    }
}

//struct RuoliView_Previews: PreviewProvider {
//    static var previews: some View {
//        RuoliView()
//    }
//}

extension View {
    func cornerRadius1(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner1: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
