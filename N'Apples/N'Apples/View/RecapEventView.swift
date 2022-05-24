//
//  RecapEventView.swift
//  N'Apples
//
//  Created by Simona Ettari on 24/05/22.
//

import Foundation
import SwiftUI

struct RecapEventView: View {
    @Binding var eventModel: EventModel
    @Binding var i: Int
    @State var presentRoleView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Text(eventModel.event[i].name)
                
                NavigationLink (destination: RoleView(i: $i, eventModel: $eventModel), isActive: $presentRoleView) {
                    Text("Role")
                        .onTapGesture {
                            presentRoleView.toggle()
                        }
                }
            }
        }
    }
}
