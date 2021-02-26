//
//  Favorite.swift
//  TestOne
//
//  Created by Муслим Курбанов on 24.02.2021.
//

import Foundation

class Cart {
    
    private(set) var items : [CartItem] = []
}

extension Cart {
    
    var totalQuantity : Int {
        get { return items.reduce(0) { value, item in
            value + item.quantity
            }
        }
    }
    
    func updateCart(with product: Image) {
        if !self.contains(product: product) {
            self.add(product: product)
        } else {
            self.remove(product: product)
        }
    }
    
    func updateCart() {
        
        for item in self.items {
            if item.quantity == 0 {
                updateCart(with: item.product)
            }
        }
    }
    
    func add(product: Image) {
        let item = items.filter { $0.product == product }
        
        if item.first != nil {
            item.first!.quantity += 1
        } else {
            items.append(CartItem(product: product))
        }
    }
    
    func remove(product: Image) {
        guard let index = items.index(where: { $0.product == product }) else { return}
        items.remove(at: index)
    }
    
    func contains(product: Image) -> Bool {
        let item = items.filter { $0.product == product }
        return item.first != nil
    }
}
