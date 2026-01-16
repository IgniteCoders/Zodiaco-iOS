//
//  SessionManager.swift
//  Zodiaco-iOS
//
//  Created by Tardes on 16/1/26.
//

import Foundation

class SessionManager {
    
    let defaults = UserDefaults.standard
    
    func setFavorite(id: String) {
        defaults.set(id, forKey: "favorite_horoscope")
    }
    
    func getFavorite() -> String {
        defaults.string(forKey: "favorite_horoscope") ?? ""
    }
    
    func isFavorite(id: String) -> Bool {
        id == getFavorite()
    }
}
