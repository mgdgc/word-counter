//
//  DataManager.swift
//  word count
//
//  Created by Peter Choi on 2018. 9. 12..
//  Copyright © 2018년 RiDsoft. All rights reserved.
//

import Foundation

class DataManager {
    
    // MARK: - Keys
    public static let appGroupName = "group.WordCounter"
    public static let arrayId = "id_array"
    public static let keySavedDoc = "doc_"
    
    private var ud = UserDefaults.standard
    
    // MARK: - Id list methods
    private func getIds() -> [Int] {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return [Int]() }
        let ids = ud.array(forKey: DataManager.arrayId) as? [Int] ?? [Int]()
        return ids
    }
    
    private func saveIds(ids: [Int]) {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return }
        ud.removeObject(forKey: DataManager.arrayId)
        ud.set(ids, forKey: DataManager.arrayId)
        
        ud.synchronize()
    }
    
    private func addId(id: Int) {
        var ids = getIds()
        ids.append(id)
        saveIds(ids: ids)
    }
    
    private func removeId(id: Int) {
        var ids = getIds()
        for i in ids.indices {
            if (ids[i] == id) {
                ids.remove(at: i)
                break
            }
        }
        
        saveIds(ids: ids)
    }
    
    // MARK: - Documents
    public func getSavedDocuments() -> [Document] {
        var savedDocs: [Document] = Array()
        
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return savedDocs }
        
        let ids = getIds()
        for id in ids {
            if let content = ud.string(forKey: String(id)) {
                let document = Document(id: id, content: content)
                savedDocs.append(document)
            }
        }
        
        return savedDocs
    }
    
    public func saveDocument(document: Document) {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return }
        
        let ids = getIds()
        for id in ids {
            if (id == document.id) {
                ud.removeObject(forKey: String(document.id))
                ud.set(document.content, forKey: String(document.id))
                return
            }
        }
        
        addId(id: document.id)
        ud.set(document.content, forKey: String(document.id))
        ud.synchronize()
    }
    
    public func removeDocument(id: Int) {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return }
        ud.removeObject(forKey: String(id))
        ud.synchronize()
    }
    
    public func removeAll() {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return }
        
        for id in getIds() {
            ud.removeObject(forKey: String(id))
        }
        
        ud.synchronize()
    }
    
}
