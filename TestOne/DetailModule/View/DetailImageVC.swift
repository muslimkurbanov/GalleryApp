//
//  DetailImageVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit
import SDWebImage
import AudioToolbox

protocol FavoriteDelegate: class {
    func append(image: UIImage)
}

protocol DetailViewDelegate: class {
    func addToFavorite(cell: GalleryCVCell)
}

protocol DetailViewProtocol: class {
    func setImages(item: Image, isLiked: Bool)
}

class DetailImageVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var addToFavorite: UIButton!

    public var cartManager = FavoriteManager.shared
    public var id: String!
    
    weak var delegate: DetailViewDelegate?
    weak var favoriteDelegare: FavoriteDelegate?
    
    var activityViewController: UIActivityViewController? = nil
    var presenter: DetailPresenterProtocol!
    
    var isLiked: Bool = false {
        didSet {
            toggleImage()
        }
    }
    
    var favoriteView: FavoriteImagesVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteDelegare = favoriteView
//        self.favoriteView
//        vc.delegate = presenter
        presenter.setImages()
        isLiked = presenter.isLiked
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let image = self.imageView.image
        self.activityViewController = UIActivityViewController(activityItems: [image ?? []], applicationActivities: nil)
        self.present(self.activityViewController!, animated: true, completion: nil)
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        let change = cartManager.selectFavorite(by: id)
        isLiked = change
        
        if isLiked {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            let image = imageView.image
            Test.shared.image = image
            
            let cell = GalleryCVCell()
            self.delegate?.addToFavorite(cell: cell)
            
            
            self.favoriteDelegare?.append(image: Test.shared.image!)

        } else {
            return
        }
    }
    
    func toggleImage() {
        let imageName = isLiked ? "filHeart" : "heart"
        addToFavorite.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension DetailImageVC: DetailViewProtocol {
    
    func setImages(item: Image, isLiked: Bool) {
        self.id = item.id
        nameLabel.text = item.description ?? "Нет названия"
        imageView.sd_setImage(with: URL(string: item.urls["regular"] ?? ""), completed: nil)
        likesLabel.text = "Нравится: \(item.likes ?? 0)"
        descriptionLabel.text = item.alt_description ?? "Нет описания"
        
        
      
    }
}

