//
//  FavoriteCollectionViewCell.swift
//  TestOne
//
//  Created by Муслим Курбанов on 23.02.2021.
//

import UIKit
import SDWebImage
import SkeletonView

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var checkmark: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    //MARK: - Functions
    private func updateSelectedState() {
        favoriteImageView.alpha = isSelected ? 0.7 : 1
        checkmark.alpha = isSelected ? 1 : 0
    }
    
    func configurate(image: Image) {
        favoriteImageView.isSkeletonable = true
        
        favoriteImageView.sd_imageTransition = .fade
        favoriteImageView.isSkeletonable = true
        favoriteImageView.showAnimatedSkeleton()
        //        favoriteImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        favoriteImageView.sd_setImage(with: URL(string: image.urls["regular"] ?? ""), completed: {_,_,_,_ in
            self.favoriteImageView.stopSkeletonAnimation()
            self.favoriteImageView.hideSkeleton()
        })
        
    }
}
