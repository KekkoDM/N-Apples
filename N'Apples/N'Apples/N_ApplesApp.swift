//
//  N_ApplesApp.swift
//  N'Apples
//
//  Created by Simona Ettari on 07/05/22.
//

import SwiftUI

@main
struct N_ApplesApp: App {
    @ObservedObject var userSettings = UserSettings()

    
    
    var body: some Scene {
        WindowGroup {
            if userSettings.id == ""{
                LoginView()
                
            }else{
      
                EventView (eventModel: eventModel, roleModel: roleModel)

            }
        }
    }
}
