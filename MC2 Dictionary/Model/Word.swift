//
//  Word.swift
//  MC2 Dictionary
//
//  Created by Yosia on 15/07/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import CloudKit

class DictionaryModel {
    
    private let database = CKContainer(identifier: "iCloud.iOS-DA.MC2-Dictionary").privateCloudDatabase
    
    var wordsRecord = [CKRecord]()
    var sentencesRecord = [CKRecord]()

    var Words = [Word]() {
        didSet {
            self.notificationQueue.addOperation {
                self.onChange?()
            }
        }
    }
    
    var Sentences = [Sentence]() {
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
    
    func searchDictionary(text: String, refreshFunc: @escaping () -> Void, errorFunc: @escaping () -> Void) {
        let predicate = NSPredicate(format: "text BEGINSWITH %@", text)
//        let predicateSentence = NSPredicate(format: "title BEGINSWITH %@", text)
//        let predicateAll = NSPredicate(value: true)
        
        let queryWords = CKQuery(recordType: Word.recordType, predicate: predicate)
//        let querySentences = CKQuery(recordType: Sentence.recordType, predicate: predicateSentence)
        print("fetching...")
        database.perform(queryWords, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                self.handle(error: error!)
                errorFunc()
                return print("error pas fetching words pak", error as Any)
            }
            if records.count < 1 {
                errorFunc()
            }
            
            print("jumlah words di model", records.count)
            self.wordsRecord = records
            self.updateWords()
            refreshFunc()
        }

//        database.perform(querySentences, inZoneWith: nil) { records, error in
//            guard let records = records, error == nil else {
//                self.handle(error: error!)
//                return print("error pas fetching sentences pak", error as Any)
//            }
//
//            print("jumlah sentences", records.count)
//            self.sentencesRecord = records
//            print("jumlah sentences yg ada", self.wordsRecord.count)
//            self.updateSentences()
//        }
    }
    
    @objc func refresh() {
        let query = CKQuery(recordType: Word.recordType, predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                self.handle(error: error!)
                return
            }
            self.wordsRecord = records
            self.updateWords()
            self.Words = records.map { record in Word(record: record) }
        }
    }
    
    private func updateWords() {

        let words = wordsRecord.map { record in Word(record: record) }
        self.Words = words
    }
    
    private func updateSentences() {
        let sentences = sentencesRecord.map { record in Sentence(record: record) }
        self.Sentences = sentences
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

struct Sentence {
    
    fileprivate static let recordType = "sentences"
    fileprivate static let keys = (description : "description", texts: "texts", title: "title", video: "video")
    
    var record : CKRecord
    
    init(record : CKRecord) {
        self.record = record
    }
    
    init() {
        self.record = CKRecord(recordType: Word.recordType)
    }
    
    var title : String {
        get {
            return self.record.value(forKey: Sentence.keys.title) as! String
        }
        set {
            self.record.setValue(newValue, forKey: Sentence.keys.title)
        }
    }
    
    var texts : [String] {
        get {
            return self.record.value(forKey: Sentence.keys.texts) as! [String]
        }
        set {
            self.record.setValue(newValue, forKey: Sentence.keys.texts)
        }
    }
    
    var description : String {
        get {
            return self.record.value(forKey: Sentence.keys.description) as! String
        }
        set {
            self.record.setValue(newValue, forKey: Sentence.keys.description)
        }
    }
    
    var video : CKAsset {
        get {
            return self.record.value(forKey: Sentence.keys.video) as! CKAsset
        }
        set {
            self.record.setValue(newValue, forKey: Sentence.keys.video)
        }
    }
}


