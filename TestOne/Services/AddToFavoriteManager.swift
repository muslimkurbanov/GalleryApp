//
//  AddToFavoriteManager.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import Foundation

final class AddToFavoriteManager {
    
    static let shared = AddToFavoriteManager()
    
    //MARK: - Properties
    
    private let defaults = UserDefaults.standard
    private let menuKey = "LIKE_PRODUCT"
    
    var dishesIds: [String] {
        let array  = defaults.array(forKey: menuKey) as? [String]
        return array ?? []
    }
    
    //MARK: - Fuctions
    
    func isAddedToFavorite(_ id: String) -> Bool {
        return dishesIds.contains(id)
    }
    
    func selectFavorite(by id: String) -> Bool {
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
    
    func removeFavorites() {
        
        defaults.removeObject(forKey: menuKey)
    }
}
