//
//  UserModel.swift
//  N'Apples
//
//  Created by Simona Ettari on 07/05/22.
//

import Foundation
import CloudKit

class RoleModel: ObservableObject {
    
    private let database = CKContainer.default().publicCloudDatabase
    
    var role = [Role]() {
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
    var insertedObjects = [Role]()
    var deletedObjectIds = Set<CKRecord.ID>()
    
    func retrieveAllUsername(username: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "username == %@", username)
        let query = CKQuery(recordType: Role.recordType, predicate: predicate)
        
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
            }
        }
        
        self.updateRole()
    }
    
    func retrieveAllCollaborators(idEvent: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "idEvent == %@", idEvent)
        let query = CKQuery(recordType: Role.recordType, predicate: predicate)
        
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
            }
        }
        
        self.updateRole()
    }
    
    func retrieveOneCollaborator(idEvent: String, username: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "idEvent == %@ AND username == %@", idEvent, username)
        let query = CKQuery(recordType: Role.recordType, predicate: predicate)
        
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
            }
        }
        
        self.updateRole()
    }
    
    
    func insert(username: String, permission: [Int], idEvent: String) async throws {
        
        var createRole = Role()
        createRole.username = username
        createRole.permission = permission
        createRole.idEvent = idEvent
        
        
        do {
            let _ = try await database.save(createRole.record)
        } catch let error {
            print(error)
            return
        }
        self.insertedObjects.append(createRole)
        self.updateRole()
        return
    }
    
    
    
    func delete(at index : Int) async throws {
        let recordId = self.role[index].record.recordID
        do {
            let _ = try await database.deleteRecord(withID: recordId)
        } catch let error {
            print(error)
            return
        }
        deletedObjectIds.insert(recordId)
        self.updateRole()
        return
    }
    
    
    
    func update(idEvent: String, usename: String, permission: [Int]) async throws {
        
        
        try await retrieveOneCollaborator(idEvent: idEvent, username: usename)
        
        if(!role.isEmpty){
            try await delete(at: 0)
            
            try await insert(username: usename, permission: permission, idEvent: idEvent)
            
            self.updateRole()
        }
    }
    
    
    
    private func updateRole() {
        
        var knownIds = Set(records.map { $0.recordID })
        
        // remove objects from our local list once we see them returned from the cloudkit storage
        self.insertedObjects.removeAll { errand in
            knownIds.contains(errand.record.recordID)
        }
        
        knownIds.formUnion(self.insertedObjects.map { $0.record.recordID })
        
        // remove objects from our local list once we see them not being returned from storage anymore
        self.deletedObjectIds.formIntersection(knownIds)
        
        var role = records.map { record in Role(record: record) }
        
        role.append(contentsOf: self.insertedObjects)
        role.removeAll { errand in
            deletedObjectIds.contains(errand.record.recordID)
        }
        
        self.role = role
        
        debugPrint("Tracking local objects \(self.insertedObjects) \(self.deletedObjectIds)")
    }
    
}

