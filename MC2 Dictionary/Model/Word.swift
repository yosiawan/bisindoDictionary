//
//  Word.swift
//  MC2 Dictionary
//
//  Created by Yosia on 15/07/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import CloudKit

class WordsModel {
    static let shared = WordsModel()
    
    private let database = CKContainer(identifier: "iCloud.iOS-DA.MC2-Dictionary").privateCloudDatabase
    
    var records = [CKRecord]()
    var insertedObjects = [Word]()
    var deletedObjectIds = Set<CKRecord.ID>()
    
    var Words = [Word]() {
        didSet {
            self.notificationQueue.addOperation {
                self.onChange?()
            }
        }
    }
    
    var onChange : (() -> Void)?
    var onError : ((Error) -> Void)?
    var notificationQueue = OperationQueue.main
    
    private func handle(error: Error) {
        self.notificationQueue.addOperation {
            self.onError?(error)
        }
    }
    
    func searchWord(text: String) {
        let predicate = NSPredicate(format: "text BEGINSWITH %@", text)
        //        let compoundPredicate = NSCompoundPredicate (andPredicateWithSubpredicates: [predicate, predicate2])
        let query = CKQuery(recordType: Word.recordType, predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                self.handle(error: error!)
                return
            }
            print("jumlah", records.count)
            self.records = records
            self.updateWords()
        }
    }
    
    @objc func refresh() {
        let query = CKQuery(recordType: Word.recordType, predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                self.handle(error: error!)
                return
            }
            self.records = records
            self.updateWords()
            self.Words = records.map { record in Word(record: record) }
        }
    }
    // ...
    func addWord(text : String) {
        
        var word = Word()
        word.text = text
        database.save(word.record) { _, error in
            guard error == nil else {
                self.handle(error: error!)
                return
            }
        }
        
        self.insertedObjects.append(word)
        self.updateWords()
    }
    
    func delete(at index : Int) {
        let recordId = self.Words[index].record.recordID
        database.delete(withRecordID: recordId) { _, error in
            guard error == nil else {
                self.handle(error: error!)
                return
            }
        }
        deletedObjectIds.insert(recordId)
        updateWords()
    }
    
    private func updateWords() {
        
        var knownIds = Set(records.map { $0.recordID })
        
        // remove objects from our local list once we see them returned from the cloudkit storage
        self.insertedObjects.removeAll { errand in
            knownIds.contains(errand.record.recordID)
        }
        knownIds.formUnion(self.insertedObjects.map { $0.record.recordID })
        
        // remove objects from our local list once we see them not being returned from storage anymore
        self.deletedObjectIds.formIntersection(knownIds)
        
        var words = records.map { record in Word(record: record) }
        
        words.append(contentsOf: self.insertedObjects)
        words.removeAll { errand in
            deletedObjectIds.contains(errand.record.recordID)
        }
        
        self.Words = words
    }
}
struct Word {
    
    fileprivate static let recordType = "Words"
    fileprivate static let keys = (description : "description", text: "text", video: "video")
    
    var record : CKRecord
    
    init(record : CKRecord) {
        self.record = record
    }
    
    init() {
        self.record = CKRecord(recordType: Word.recordType)
    }
    
    var text : String {
        get {
            return self.record.value(forKey: Word.keys.text) as! String
        }
        set {
            self.record.setValue(newValue, forKey: Word.keys.text)
        }
    }
    
    var description : String {
        get {
            return self.record.value(forKey: Word.keys.description) as! String
        }
        set {
            self.record.setValue(newValue, forKey: Word.keys.description)
        }
    }
    
    var video : CKAsset {
        get {
            return self.record.value(forKey: Word.keys.video) as! CKAsset
        }
        set {
            self.record.setValue(newValue, forKey: Word.keys.video)
        }
    }
}
