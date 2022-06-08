//
//  EventModel.swift
//  N'Apples
//
//  Created by Simona Ettari on 07/05/22.
//

import Foundation
import CloudKit
import SwiftUI

class EventModel: ObservableObject {
    
    private let database = CKContainer.default().publicCloudDatabase
    //    private var roleModel: RoleModel = RoleModel()
    
    var event = [Event]() {
        didSet {
            self.notificationQueue.addOperation {
                self.onChange?()
            }
        }
    }
    
    var onChange : (() -> Void)?
    var onError : ((Error) -> Void)?
    var notificationQueue = OperationQueue.main
    
    var records = [CKRecord]()
    var insertedObjects = [Event]()
    var deletedObjectIds = Set<CKRecord.ID>()
    
    func retrieveAllName(name: String) async throws {
        
        let predicate: NSPredicate = NSPredicate(format: "name == %@", name)
        let query = CKQuery(recordType: Event.recordType, predicate: predicate)
        
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
            }
        }
        self.updateEvent()
    }
    
    func retrieveAllId(id: String) async throws {
                
        let predicate: NSPredicate = NSPredicate(format: "id == %@", id)
        let query = CKQuery(recordType: Event.recordType, predicate: predicate)
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records.append(data)
                
            }
        }
        self.updateEvent()
    }
    
    func retrieveAll(name: String, location: String, date: Date) async throws {
        let predicate: NSPredicate = NSPredicate(format: "name == %@ AND location == %@ AND date == %@ ", name, location, date as CVarArg)
        let query = CKQuery(recordType: Event.recordType, predicate: predicate)
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
            }
        }
        self.updateEvent()
    }
    
    func insertAll(name: String, address: String, location: String, info: String,/* poster: CKAsset,*/ capability: Int, date: Date, lists: [String], table: [String], price: [Int], timeForPrice: [Date]) async throws {
        
        var createEvent = Event()
        createEvent.name = name
        createEvent.address = address
        createEvent.location = location
        createEvent.info = info
        createEvent.capability = capability
        createEvent.date = date
        createEvent.lists = lists
        createEvent.table = table
        createEvent.price = price
        createEvent.timeForPrice = timeForPrice
        
        do {
            let _ = try await database.save(createEvent.record)
        } catch let error {
            print(error)
            return
        }
        self.insertedObjects.append(createEvent)
        self.updateEvent()
        return
    }
    
    func reset(){
        records.removeAll()
        event.removeAll()
    }
    
    func insertEvent(name: String, address: String, location: String, info: String, imagePoster: UIImage?, capability: Int, date: Date, timeForPrice: [Date], price: [Int], table: [String]) async throws {
        print("insertevent 1")
        
        var createEvent = Event()
        createEvent.id = UUID().uuidString
        createEvent.name = name
        createEvent.address = address
        createEvent.location = location
        createEvent.info = info
        createEvent.capability = capability
        createEvent.date = date
        createEvent.timeForPrice = timeForPrice
        createEvent.price = price
        createEvent.table = table
        
        try await roleModel.insert(username: userModel.user.first!.username, permission: 3, idEvent: createEvent.id)
        
        guard
            let image = imagePoster,
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("Giorgio.jpeg"),
            let data = image.jpegData(compressionQuality: 1.0) else { return }
        
        print("insertevent 3")
        
        do {
            print("insertevent 4")
            
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            createEvent.poster = asset
            
            let _ = try await database.save(createEvent.record)
            print("insertevent 5")
            
        } catch let error {
            print(error)
            return
        }
        self.insertedObjects.append(createEvent)
        self.updateEvent()
        return
    }
    
    
    
    func delete(at index : Int) async throws {
        let recordId = self.event[index].record.recordID
        do {
            let _ = try await database.deleteRecord(withID: recordId)
        } catch let error {
            print(error)
            return
        }
        deletedObjectIds.insert(recordId)
        self.updateEvent()
        return
    }
    
    func update(event: Event, name: String, address: String, location: String, info: String, poster: CKAsset, capability: Int, date: Date, lists: [String], table: [String], price: [Int]) async throws {
        
        var singleEvent = Event()
        singleEvent.name = name
        singleEvent.address = address
        singleEvent.location = location
        singleEvent.info = info
        singleEvent.poster = poster
        singleEvent.capability = capability
        singleEvent.date = date
        singleEvent.lists = lists
        singleEvent.table = table
        singleEvent.price = price
        
        let _ = try await self.database.modifyRecords(saving: [singleEvent.record], deleting: [event.record.recordID], savePolicy: .changedKeys, atomically: true)
        self.updateEvent()
    }
    
    private func updateEvent() {
        
        var knownIds = Set(records.map { $0.recordID })
        
        // remove objects from our local list once we see them returned from the cloudkit storage
        self.insertedObjects.removeAll { errand in
            knownIds.contains(errand.record.recordID)
        }
        knownIds.formUnion(self.insertedObjects.map { $0.record.recordID })
        
        // remove objects from our local list once we see them not being returned from storage anymore
        self.deletedObjectIds.formIntersection(knownIds)
        
        var event = records.map { record in Event(record: record) }
        
        event.append(contentsOf: self.insertedObjects)
        event.removeAll { errand in
            deletedObjectIds.contains(errand.record.recordID)
        }
        
        self.event = event
        
        debugPrint("Tracking local objects \(self.insertedObjects) \(self.deletedObjectIds)")
    }
    
    func loadCoverPhoto(completion: @escaping (_ photo: UIImage?) -> ()) {
        // 1.
        DispatchQueue.global(qos: .utility).async {
            var image: UIImage?
            // 5.
            defer {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            // 2.
            guard
                let poster = self.event.first?.poster,
                let fileURL = poster.fileURL
            else {
                return
            }
            let imageData: Data
            do {
                // 3.
                imageData = try Data(contentsOf: fileURL)
            } catch {
                return
            }
            // 4.
            image = UIImage(data: imageData)
        }
    }
    
}

