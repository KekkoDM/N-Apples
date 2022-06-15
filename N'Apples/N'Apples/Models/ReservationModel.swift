//
//  ReservationModel.swift
//  N'Apples
//
//  Created by Simona Ettari on 07/05/22.
//

import Foundation
import CloudKit
import CoreMIDI

class ReservationModel: ObservableObject {
    
    private let database = CKContainer.default().publicCloudDatabase
    
    var reservation = [Reservation]() {
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
    var insertedObjects = [Reservation]()
    var deletedObjectIds = Set<CKRecord.ID>()
    
    func retrieveAllEmail(email: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "email == %@", email)
        let query = CKQuery(recordType: User.recordType, predicate: predicate)
        
        
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
                self.updateReservation()
            }
        }
    }
    
    func retrieveAllIdDecrypt(id: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "id == %@", id)
        let query = CKQuery(recordType: Reservation.recordType, predicate: predicate)
        
        let tmp = try await self.database.records(matching: query)
        print(tmp.matchResults)
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
                
            }

        }
        
        self.updateReservation()

        let key = keyFromPassword(id)
        
        for i in 0..<reservation.count {
            reservation[i].name = try decryptStringToCodableOject(String.self, from: reservation[i].name, usingKey: key)
            reservation[i].surname = try decryptStringToCodableOject(String.self, from: reservation[i].surname, usingKey: key)
            reservation[i].email = try decryptStringToCodableOject(String.self, from: reservation[i].email, usingKey: key)
        }

    }
    
    func retrieveAllEventIdDecrypt(idEvent: String) async throws {
        
        records.removeAll()
        reservation.removeAll()
        let predicate: NSPredicate = NSPredicate(format: "idEvent == %@", idEvent)
        let query = CKQuery(recordType: Reservation.recordType, predicate: predicate)
        
        
        let tmp = try await self.database.records(matching: query)
        print(tmp.matchResults)
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records.append(data)
                
            }

        }
        
        self.updateReservation()

        
        
        for i in 0..<reservation.count {
            let key = keyFromPassword(reservation[i].id)
            reservation[i].name = try decryptStringToCodableOject(String.self, from: reservation[i].name, usingKey: key)
            reservation[i].surname = try decryptStringToCodableOject(String.self, from: reservation[i].surname, usingKey: key)
            reservation[i].email = try decryptStringToCodableOject(String.self, from: reservation[i].email, usingKey: key)
            
        }

    }
    
 
    func retrieveAllId(id: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "id == %@", id)
        let query = CKQuery(recordType: Reservation.recordType, predicate: predicate)
        
        
        let tmp = try await self.database.records(matching: query)
        print(tmp.matchResults)
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
                
            }

        }
        
        self.updateReservation()


    }
    
    
    func retrieveAllName(name: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "name == %@", name)
        let query = CKQuery(recordType: Reservation.recordType, predicate: predicate)
        
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
            }
        }
        self.updateReservation()
        
    }
    
    func insert(event: String,id: String, name: String, surname: String, email: String, nameList: String, numFriends: Int) async throws {
        
        var createReservation = Reservation()
        createReservation.idEvent = event
        createReservation.id = id
        createReservation.name = try encryptParameter(id, name)
        createReservation.surname = try encryptParameter(id, surname)
        createReservation.email = try encryptParameter(id, email)
        createReservation.nameList = nameList
        createReservation.numFriends = numFriends
        createReservation.numScan = 0
        
        do {
            let _ = try await database.save(createReservation.record)
        } catch let error {
            print(error)
            return
        }
        self.insertedObjects.append(createReservation)
        self.updateReservation()
        return
    }
    
    func insert(id: String, name: String, surname: String, email: String, nameList: String, numFriends: Int, numScan: Int) async throws {
        
        var createReservation = Reservation()
        createReservation.id = id
        createReservation.name = name
        createReservation.surname = surname
        createReservation.email = email
        createReservation.nameList = nameList
        createReservation.numFriends = numFriends
        createReservation.numScan = numScan
        
        do {
            let _ = try await database.save(createReservation.record)
        } catch let error {
            print(error)
            return
        }
        self.insertedObjects.append(createReservation)
        self.updateReservation()
        return
    }
    
    
    
    
//    func insert(res: Reservation) async throws {
//
//
//        do {
//            let _ = try await database.save(res.record)
//        } catch let error {
//            print(error)
//            return
//        }
//        self.insertedObjects.append(res)
//        self.updateReservation()
//    }
    
    func delete(at index : Int) async throws {
        let recordId = self.reservation[index].record.recordID
        do {
            let _ = try await database.deleteRecord(withID: recordId)
        } catch let error {
            print(error)
            return
        }
        deletedObjectIds.insert(recordId)
        self.updateReservation()
        return
    }
    
//    func updateNumScan(id:String) async throws {
//
//        try await retrieveAllId(id: id)
//
//        var rec = reservation.first!
//
//        rec.numScan = rec.numScan+1
//
//        let _ = try await self.database.modifyRecords(saving: [rec.record], deleting: [rec.record.recordID], savePolicy: .changedKeys, atomically: true)
//        self.updateReservation()
//    }
    
    
    
    
    func updateNumScan(id:String,numscan:Int) async throws ->Bool{
        
        try await retrieveAllId(id: id)
        
        var rec = reservation.first!
        
        rec.numScan = numscan
    
        for i in 0..<reservation.count{
            print("Cancello \(reservation[i].id)")
            try await delete(at: i)
        }
        
        try await insert(id: rec.id, name: rec.name, surname: rec.surname, email: rec.email, nameList: rec.nameList, numFriends: rec.numFriends, numScan: rec.numScan)
        
        
        try await retrieveAllIdDecrypt(id: id)
        
        self.updateReservation()
        return false
    }
    
    func update(reservation1: Reservation, id: String, name: String, surname: String, email: String, nameList: String, timeScan: Date, numFriends: Int, numScan: Int) async throws {
        

        
        try await retrieveAllId(id: id)
        
        if(!reservation.isEmpty){
            try await delete(at: 0)
            //            let _ = try await self.database.modifyRecords(saving: [singleReservation.record], deleting: [reservation1.record.recordID], savePolicy: .changedKeys, atomically: true)
            
            try await insert(id: id, name: name, surname: surname, email: email, nameList: nameList, numFriends: numFriends, numScan: numScan)
            
            self.updateReservation()
        }
    }
    
    func update2(reservation1: Reservation, id: String, name: String, surname: String, email: String, nameList: String, timeScan: Date, numFriends: Int, numScan: Int) async throws {
        

        var createReservation = Reservation()
        createReservation.id = id
        createReservation.name = name
        createReservation.surname = surname
        createReservation.email = email
        createReservation.nameList = nameList
        createReservation.numFriends = numFriends
        createReservation.numScan = numScan + 1
        let _ = try await self.database.modifyRecords(saving: [createReservation.record], deleting: [reservation1.record.recordID], savePolicy: .changedKeys, atomically: true)
            self.updateReservation()
        
    }
    
    private func updateReservation() {
        
        var knownIds = Set(records.map { $0.recordID })
        
        // remove objects from our local list once we see them returned from the cloudkit storage
        self.insertedObjects.removeAll { errand in
            knownIds.contains(errand.record.recordID)
        }
        knownIds.formUnion(self.insertedObjects.map { $0.record.recordID })
        
        // remove objects from our local list once we see them not being returned from storage anymore
        self.deletedObjectIds.formIntersection(knownIds)
        
        var reservation = records.map { record in Reservation(record: record) }
        
        reservation.append(contentsOf: self.insertedObjects)
        reservation.removeAll { errand in
            deletedObjectIds.contains(errand.record.recordID)
        }
        
        self.reservation = reservation
        
        debugPrint("Tracking local objects \(self.insertedObjects) \(self.deletedObjectIds)")
    }
    
}


