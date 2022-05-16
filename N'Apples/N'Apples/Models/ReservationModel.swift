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
    
    func retrieveAllId(id: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "id == %@", id)
        let query = CKQuery(recordType: Reservation.recordType, predicate: predicate)
        
        
        let tmp = try await self.database.records(matching: query)
        print(tmp.matchResults)
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
                self.updateReservation()
            }
        }
    }
    
 
    
    //    func retrieveAllName(name: String) async throws {
    //        let predicate: NSPredicate = NSPredicate(format: "name == %@", name)
    //        let query = CKQuery(recordType: Event.recordType, predicate: predicate)
    //
    //        let tmp = try await self.database.records(matching: query)
    //
    //        for tmp1 in tmp.matchResults{
    //            if let data = try? tmp1.1.get() {
    //                self.records = [data]
    //            }
    //        }
    //        self.updateEvent()
    //    }
    
    func retrieveAllName(name: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "name == %@", name)
        let query = CKQuery(recordType: Reservation.recordType, predicate: predicate)
        
        print(" OGGETTI PRIMA : \(reservation)")
        
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
            }
        }
        self.updateReservation()
        
        print(" OGGETTI : \(reservation)")
    }
    
    func insert(id: String, name: String, surname: String, email: String, nameList: String, numFriends: Int) async throws {
        
        var createReservation = Reservation()
        createReservation.id = id
        createReservation.name = name
        createReservation.surname = surname
        createReservation.email = email
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
    
    
    func insert(res: Reservation) async throws {
        
        
        do {
            let _ = try await database.save(res.record)
        } catch let error {
            print(error)
            return
        }
        self.insertedObjects.append(res)
        self.updateReservation()
        return
    }
    
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
    
    func updateNumScan(reservation: Reservation, numScan: Int) async throws {
        
        var singleReservation = reservation
        singleReservation.numScan = numScan
        
        let _ = try await self.database.modifyRecords(saving: [singleReservation.record], deleting: [reservation.record.recordID], savePolicy: .changedKeys, atomically: true)
        self.updateReservation()
    }
    
    func updatepzzot(at index : Int,id:String) async throws {
        
        try await retrieveAllId(id: id)
        
        var rec = reservation.first!
        
        rec.numScan = rec.numScan+1
    
        for i in 0..<reservation.count{
            print("Cancello \(reservation[i].id)")
            try await delete(at: i)
        }
        
        try await insert(id: rec.id, name: rec.name, surname: rec.surname, email: rec.email, nameList: rec.nameList, numFriends: rec.numFriends, numScan: rec.numScan)
        
        

        
        self.updateReservation()
    }
    
    func update(reservation1: Reservation, id: String, name: String, surname: String, email: String, nameList: String, timeScan: Date, numFriends: Int, numScan: Int) async throws {
        
        //        var singleReservation = Reservation()
        //        singleReservation.id = id
        //        singleReservation.name = name
        //        singleReservation.surname = surname
        //        singleReservation.email = email
        //        singleReservation.nameList = nameList
        //        singleReservation.timeScan = timeScan
        //        singleReservation.numFriends = numFriends
        //        singleReservation.  = numScan
        
        
        try await retrieveAllId(id: id)
        
        if(!reservation.isEmpty){
            try await delete(at: 0)
            //            let _ = try await self.database.modifyRecords(saving: [singleReservation.record], deleting: [reservation1.record.recordID], savePolicy: .changedKeys, atomically: true)
            
            try await insert(id: id, name: name, surname: surname, email: email, nameList: nameList, numFriends: numFriends, numScan: numScan)
            
            self.updateReservation()
        }
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
        print("NUMERO UPDATE : \(self.reservation.count)")
        
        self.reservation = reservation
        
        debugPrint("Tracking local objects \(self.insertedObjects) \(self.deletedObjectIds)")
    }
    
}


