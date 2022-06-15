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
    @State var  showCaricamento = false
    @Binding var indici: [Int]
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
                .padding(.bottom,20)
                
               
                
                Text("Role Recap")
                    .font(.title3)
                
                
                ScrollView {
                    
                    Spacer()
                    VStack(spacing: 60.0) {
                        ForEach(0 ..< roleModel.role.count, id: \.self) { i in
                            Divider()
                            
                            RuoliView(roleModel: $roleModel, Ruoli:[RuoliView.ParametriRuoli(ruolo: roleModel.role[i].permission.map{String($0) }, email: roleModel.role[i].username)])
                        }
                    }
                    Spacer()
                }
            }
            if  showCaricamento {
                GifFile(eventModel: eventModel, roleModel: roleModel, indici: $indici)

            }
        }
        
        .sheet(isPresented: $presentAssignRoleView,onDismiss: {
            showCaricamento = true
        }) {
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
    @State var descrizione: String = ""
    
    struct ParametriRuoli:Identifiable {
        var id: [String] {
            self.ruolo
            
        }
        var ruolo: [String]
        var email: String
//        var nome: String
//        var cognome: String
    }
    
    @State private var showingSheet = false
    @State var Ruoli: [ParametriRuoli] = [ParametriRuoli(ruolo: ["PR"], email: "simi@libero.it")]
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack{
                
                Color(red: 11 / 255, green: 41 / 255, blue: 111 / 255)
                    .ignoresSafeArea()
                
//                ForEach(Ruoli) {  index in
                    
                    
                    VStack(alignment: .center, spacing: 10){
                        
                        Text("\(descrizione)")
                        
                            .font(.system(size: 18))
                            .foregroundColor(.orange)
                        
                        Text("\(Ruoli.first!.email)")
                        Spacer()
                          
                    }.frame(width: 200, height: 50, alignment: .center)
//                    .position(x: geometry.size.width*0.3, y: geometry.size.height*0.14)
                    
                    .foregroundColor(.white)
//                }
                
                
            }.onAppear(){
                descrizione = Ruoli.first!.ruolo.description
                let removeCharacters: Set<Character> = ["[", ",", "\"", "]"]
                descrizione.removeAll(where: { removeCharacters.contains($0) } )
                
                
                if(descrizione == "0 0 0") {
                    descrizione = "Manager"
                }
                if(descrizione == "0 1 0") {
                    descrizione = "Collaborator"
                }
                if(descrizione == "0 0 1") {
                    descrizione = "Guardian"
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
