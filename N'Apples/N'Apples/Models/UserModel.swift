//
//  UserModel.swift
//  N'Apples
//
//  Created by Simona Ettari on 07/05/22.
//

import Foundation
import CloudKit

class UserModel: ObservableObject {
    
    private let database = CKContainer.default().publicCloudDatabase
    
    var user = [User]() {
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
    var insertedObjects = [User]()
    var deletedObjectIds = Set<CKRecord.ID>()
    
    func retrieveAllUsernamePassword(username: String, password: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        let query = CKQuery(recordType: User.recordType, predicate: predicate)
        
        let tmp = try await self.database.records(matching: query)
       
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
            }
        }
        
        self.updateUser()
    }
    
    func retrieveAllId(username: String) async throws {
        let predicate: NSPredicate = NSPredicate(format: "username == %@", username)
        let query = CKQuery(recordType: User.recordType, predicate: predicate)
        
        let tmp = try await self.database.records(matching: query)
        
        for tmp1 in tmp.matchResults{
            if let data = try? tmp1.1.get() {
                self.records = [data]
            }
        }
        
        self.updateUser()
    }
    
    func insert(username: String, password: String, email: String) async throws {
        
        var createUser = User()
        createUser.username = username
        createUser.password = password
        createUser.email = email
        
        do {
            let _ = try await database.save(createUser.record)
        } catch let error {
            print(error)
            return
        }
        self.insertedObjects.append(createUser)
        self.updateUser()
        return
    }
    
    func delete(at index : Int) async throws {
        let recordId = self.user[index].record.recordID
        do {
            let _ = try await database.deleteRecord(withID: recordId)
        } catch let error {
            print(error)
            return
        }
        deletedObjectIds.insert(recordId)
        self.updateUser()
        return
    }
    
    func update(user: User, username: String, password: String) async throws {
            
        var singleUser = User()
        singleUser.username = username
        singleUser.password = password
          
        let _ = try await self.database.modifyRecords(saving: [singleUser.record], deleting: [user.record.recordID], savePolicy: .changedKeys, atomically: true)
            self.updateUser()
    }
    
    func updatePw(user: User, password: String) async throws {
            
        var singleUser = User()
        singleUser.username = user.username
        singleUser.password = password
          
        let _ = try await self.database.modifyRecords(saving: [singleUser.record], deleting: [user.record.recordID], savePolicy: .changedKeys, atomically: true)
            self.updateUser()
    }
    
    private func updateUser() {
        
        var knownIds = Set(records.map { $0.recordID })
        
        // remove objects from our local list once we see them returned from the cloudkit storage
        self.insertedObjects.removeAll { errand in
            knownIds.contains(errand.record.recordID)
        }
        
        knownIds.formUnion(self.insertedObjects.map { $0.record.recordID })
        
        // remove objects from our local list once we see them not being returned from storage anymore
        self.deletedObjectIds.formIntersection(knownIds)
        
        var user = records.map { record in User(record: record) }
        
        user.append(contentsOf: self.insertedObjects)
        user.removeAll { errand in
            deletedObjectIds.contains(errand.record.recordID)
        }
        
        self.user = user
        
        debugPrint("Tracking local objects \(self.insertedObjects) \(self.deletedObjectIds)")
    }
    
}

