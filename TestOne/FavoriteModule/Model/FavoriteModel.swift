//
//  FavoriteModel.swift
//  TestOne
//
//  Created by Муслим Курбанов on 26.02.2021.
//

import Foundation


struct FavoriteImages {
    
    static var shared = FavoriteImages()
    var items: [Image] = []
        

    
    
}

final class UserSettings {
    
    static var shared = UserSettings()
    
    private enum SettingsKeys: String {
        case imageArrayKey
    }
    
    static var imageArray: [Image]! {
        get {
            return UserDefaults.standard.array(forKey: SettingsKeys.imageArrayKey.rawValue) as? [Image]
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.imageArrayKey.rawValue
            if let image = newValue {
                defaults.set(image, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}

class SaveManager {
    static let shared = SaveManager()
    private init() {}
    
    private let defaults = UserDefaults.standard
    private let menuKey = "LIKE_PRODUCT"
    
    var dishesIds: [Image] {
        let array  = defaults.array(forKey: menuKey) as? [Image]
        return array ?? []
    }
    
    func isAddedToFavorite(_ id: Image) -> Bool {
        return dishesIds.contains(id)
    }
    
    func selectFavorite(by id: Image) -> Bool {
        var added: Bool
        var dishesCopy = dishesIds
        
        if dishesCopy.contains(id), let index = dishesCopy.firstIndex(of: id) {
            dishesCopy.remove(at: index)
            added = false
        } else {
            dishesCopy.append(id)
            added = true
        }
        defaults.set(dishesCopy, forKey: menuKey)
        return added
    }
}
