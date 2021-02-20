//
//  MainCVCell.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit
import SDWebImage

class GalleryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configurate(model: Image) {
        imageView.sd_setImage(with: URL(string: model.urls["thumb"] ?? ""), completed: nil)
//        imageName.text = model.description ?? "Нет названия"
    }
}
