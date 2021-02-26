//
//  FavoriteItem.swift
//  TestOne
//
//  Created by Муслим Курбанов on 24.02.2021.
//

import Foundation

class CartItem {
    
    var quantity : Int = 1
    var product : Image
    
//    var subTotal : Float { get { return product.price * Float(quantity) } }
    
    init(product: Image) {
        self.product = product
    }
}
