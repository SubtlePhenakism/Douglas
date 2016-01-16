//
//  LocalStore.swift
//  Excalibur
//
//  Created by Robert Passemar on 9/10/15.
//  Copyright (c) 2015 TreeNine. All rights reserved.
//

import UIKit

struct LocalStore {
    static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    static func saveToken(token: String) {
        userDefaults.setObject(token, forKey: "tokenKey")
    }
    
    static func getToken() -> String? {
        return userDefaults.stringForKey("tokenKey")
    }
    
    static func deleteToken() {
        userDefaults.removeObjectForKey("tokenKey")
    }
    
    
    // MARK: Helper
    
    private static func arrayForKey(key: String, containsId id: Int) -> Bool {
        let elements = userDefaults.arrayForKey(key) as? [Int] ?? []
        return elements.contains(id)
    }
    
    private static func appendId(id: Int, toKey key: String) {
        let elements = userDefaults.arrayForKey(key) as? [Int] ?? []
        if !elements.contains(id) {
            userDefaults.setObject(elements + [id], forKey: key)
        }
    }
}
