//
//  ProfileScreenProductCell.swift
//  TestOne
//
//  Created by Муслим Курбанов on 10.07.2021.
//

import UIKit

class ProfileScreenProductCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 20
    }
    
    func configurate(name: String) {
        nameLabel.text = name
    }
}
