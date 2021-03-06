//
//  FavoriteManager.swift
//  TestOne
//
//  Created by Муслим Курбанов on 03.03.2021.
//

import Foundation

final class FavoriteManager {
    
    static var shared = FavoriteManager()
    
    private let defaults = UserDefaults.standard
    let menuKey = "ADDED_PRODUCT"
    
    var images: [Image] = []
    private var id: String!
    
    private init() {
        guard let array = defaults.object(forKey: menuKey) as? Data,
              let images = try? JSONDecoder().decode([Image].self, from: array) else { return }
        self.images = images
    }
    
    func save(image: Image) {
        
        if !images.contains(where: {$0.id == image.id}) {
            images.append(image)
        }
        
        if let data = try? JSONEncoder().encode(images) {
            defaults.setValue(data, forKey: menuKey)
        }
    }
    
    func update() {
        let defaults = UserDefaults.standard
        if let savedImages = defaults.object(forKey: menuKey) as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                images = try jsonDecoder.decode([Image].self, from: savedImages)
            } catch {
                print("Failed to load images from update")
            }
        }
    }
    
    func delete(presenter: DetailPresenterProtocol, image: Image) {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(images) {
            self.id = presenter.image.id
            let defaults = UserDefaults.standard
            if !images.isEmpty && presenter.image.id == id {
                guard let index = images.firstIndex(where: { $0.id == id }) else { return }
                images.remove(at: index)
                
                if let data = try? JSONEncoder().encode(images) {
                    defaults.setValue(data, forKey: menuKey)
                }
                images.append(presenter.image)
            } else {
                print("Failed to save images from delete")
            }
        }
    }
}
