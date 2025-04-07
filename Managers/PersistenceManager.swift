//
//  PersistenceManager.swift
//  ARViewerModular
//
//  Created by Alejandro Beltrán on 1/16/25.
//

import ARKit

public protocol PersistenceManager {
    func save<T: Codable>(_ object: T, forKey key: String)
    func retrieve<T: Codable>(_ type: T.Type, forKey key: String) -> T?
}

// UserDefaults Implementation 
public class UserDefaultsPersistenceManager: PersistenceManager {
    public func save<T>(_ object: T, forKey key: String) where T: Codable {
        if let data = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    public func retrieve<T>(_ type: T.Type, forKey key: String) -> T? where T: Codable {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

