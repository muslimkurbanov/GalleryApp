//
//  FavoriteCollectionViewCell.swift
//  TestOne
//
//  Created by Муслим Курбанов on 23.02.2021.
//

import UIKit
import SDWebImage

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    func configurate(image: UIImage) {
        favoriteImageView.image = image
    }
}
