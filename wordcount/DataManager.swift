//
//  DataManager.swift
//  word count
//
//  Created by Peter Choi on 2018. 9. 12..
//  Copyright © 2018년 RiDsoft. All rights reserved.
//

import Foundation

class DataManager {
    
    public static let appGroupName = "group.WordCounter"
    public static let keySavedDoc = "doc_"
    
    enum ErrorType {
        case Success
        case NotEnoughSpace
        case TooManySavedItems
        case NeedUpgrade
    }
    
    private var ud = UserDefaults.standard
    
    public func getSavedDocuments() -> [SavedDocObject] {
        var savedDocs: [SavedDocObject] = Array()
        
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return savedDocs }
        
        for i in 0..<50 {
            let key = DataManager.keySavedDoc + String(i)
            if let docString = ud.string(forKey: key) {
                let doc = SavedDocObject(position: i, content: docString)
                savedDocs.append(doc)
            } else {
                return savedDocs
            }
        }
        
        return savedDocs
    }
    
    public func saveDocument(doc: SavedDocObject) -> Bool {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return false }
        
        ud.set(doc.content, forKey: doc.getKey())
        ud.synchronize()
        
        return true
    }
    
    public func saveDocument(docs: [SavedDocObject]) -> Bool {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return false }
        
        for doc in docs {
            ud.set(doc.content, forKey: doc.getKey())
        }
        ud.synchronize()
        
        return true
    }
    
    public func removeAll() {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return }
        
        for i in 0..<50 {
            let key = DataManager.keySavedDoc + String(i)
            if ud.string(forKey: key) != nil {
                ud.removeObject(forKey: key)
            }
        }
    }
    
    enum DocumentSaveResult {
        case success
        case tooManyItems
        case unknownError
        case noAppGroup
    }
    
    public func addDocument(content: String) -> DocumentSaveResult {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return .noAppGroup }
        
        let savedDocument = getSavedDocuments()
        
        if savedDocument.count >= 49 {
            return .tooManyItems
        }
        
        ud.set(content, forKey: DataManager.keySavedDoc + String(savedDocument.count))
        ud.synchronize()
        
        return .success
    }
    
    // index를 인자로 받는 경우
    public func removeDocument(position: Int) -> Bool {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return false }
        
        var original = getSavedDocuments()
        original.remove(at: position)
        
        var strings: [String] = Array()
        for doc in original {
            strings.append(doc.content)
        }
        
        removeAll()
        
        for i in 0..<strings.count {
            ud.set(strings, forKey: DataManager.keySavedDoc + String(i))
        }
        
        ud.synchronize()
        
        return true
    }
    
    // SavedDocObject를 인자로 받는 경우
    public func removeDocument(doc: SavedDocObject) -> Bool {
        removeDocument(position: doc.position)
        return true
    }
    
}
