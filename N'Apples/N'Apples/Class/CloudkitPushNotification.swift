//
//  CloudkitPushNotification.swift
//  N'Apples
//
//  Created by Nicola D'Abrosca on 17/05/22.
//

import Foundation
import SwiftUI
import CloudKit

class CloudkitPushNotificationViewModel: ObservableObject{
    
    func requestNotificationPermission(){
        let options:UNAuthorizationOptions = [.alert,.sound,.badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler:
                                                                    { succes,error in
            if let error = error {
                print(error)
            } else if succes {
                print("Notification permission succes")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else{
                print("Notification Permission failure")
            }
        })
    }
    
    func subscribe(textType: String) {
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: textType, predicate: predicate, subscriptionID: "event_added_to_database", options: .firesOnRecordCreation)
  
        let notification = CKSubscription.NotificationInfo()
       
        if (textType == "Role") {
            notification.title = "You have been assigned to a new role"
            notification.alertBody = "Open the app to view this"
        } else if (textType == "Event") {
            notification.title = "There's a new Event"
            notification.alertBody = "Open the app to join"
        }
        notification.soundName = "default"
        
        subscription.notificationInfo = notification
        CKContainer.default().publicCloudDatabase.save(subscription){ returnedSubscription,returnedError in
            if let error = returnedError{
                print(error)
            } else {
                print("Success subscribed to notification")
            }
        }
    }
    
    func unsubscribe() {
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "event_added_to_database") {
            returnedId,returnedError in
            if let error = returnedError{
                print(error)
            }else{
                print("Success unsubscribed to notification")
            }
            
        }
    }
}

//struct CloudkitPushNotification:View {
//    @StateObject private var vm = CloudkitPushNotificationViewModel()
//    var body: some View{
//        ZStack {
//            Color.white
//            VStack {
//                Button(action: {
//
//                    vm.requestNotificationPermission()
//
//                }, label: {
//                    Text("Ask Permission")
//
//                })
//
//                Button(action: {
//
//                    vm.subscribe()
//
//                }, label: {Text("Subscribe")
//
//                })
//                Button(action: {
//
//                    vm.unsubscribe()
//
//                }, label: {Text("UnSubscribe")
//
//                })
//
//            }
//        }
//    }
//
//}
