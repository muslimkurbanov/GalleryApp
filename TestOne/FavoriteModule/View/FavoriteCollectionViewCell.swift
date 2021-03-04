//
//  FavoriteCollectionViewCell.swift
//  TestOne
//
//  Created by Муслим Курбанов on 23.02.2021.
//

import UIKit
import SDWebImage

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBOutlet weak var checkmark: UIImageView!
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
            
        }
    }
    
    private func updateSelectedState() {
        favoriteImageView.alpha = isSelected ? 0.7 : 1
        checkmark.alpha = isSelected ? 1 : 0

    }
    
    //MARK: - Functions
    func configurate(image: Image) {
//        addSubview(checkmark)
//        checkmark.trailingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: -8).isActive = true
//        checkmark.bottomAnchor.constraint(equalTo: favoriteImageView.bottomAnchor, constant: -8).isActive = true
        favoriteImageView.sd_setImage(with: URL(string: image.urls["small"] ?? ""), completed: nil)
    }
}
