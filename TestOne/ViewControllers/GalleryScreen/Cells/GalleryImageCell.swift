//
//  GalleryImageCell.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit
import SDWebImage
import SkeletonView

final class GalleryImageCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configurate(model: Image) {
        
        imageView.isSkeletonable = true
        imageView.showAnimatedSkeleton()
        imageView.sd_imageTransition = .fade
//        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: URL(string: model.urls["regular"] ?? ""), completed: {_,_,_,_ in
            self.imageView.stopSkeletonAnimation()
            self.imageView.hideSkeleton()
        })
    }
}
