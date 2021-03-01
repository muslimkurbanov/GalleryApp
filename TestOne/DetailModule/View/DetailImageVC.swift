//
//  DetailImageVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit
import SDWebImage
import AudioToolbox

//MARK: - Protocols
protocol DetailViewDelegate: class {
    func addToFavorite(cell: GalleryCVCell)
}

protocol DetailViewProtocol: class {
    func setImages(item: Image, isLiked: Bool)
}

class DetailImageVC: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToFavorite: UIButton!

    public var cartManager = FavoriteManager.shared
    public var id: String!
    
    weak var delegate: DetailViewDelegate?
    
    var activityViewController: UIActivityViewController? = nil
    var presenter: DetailPresenterProtocol!
    var favoriteView: FavoriteImagesVC?
    
    var isLiked: Bool = false {
        didSet {
            toggleImage()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setImages()
        isLiked = presenter.isLiked
    }
    
    //MARK: - IBActions
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
            
            FavoriteImages.shared.items.append(presenter.images)
            likesLabel.text = "Нравится: \(presenter.images.likes! + 1)"
            
        } else {
            
            if FavoriteImages.shared.items != [] {
                FavoriteImages.shared.items.removeLast()
                likesLabel.text = "Нравится: \(presenter.images.likes ?? 0)"
            } else {
                likesLabel.text = "Нравится: \(presenter.images.likes ?? 0)"
                return
            }
        }
    }
    
    func toggleImage() {
        let imageName = isLiked ? "filHeart" : "heart"
        addToFavorite.setImage(UIImage(named: imageName), for: .normal)
    }
}

//MARK: - DetailViewProtocol
extension DetailImageVC: DetailViewProtocol {
    
    func setImages(item: Image, isLiked: Bool) {
        self.id = item.id
        nameLabel.text = item.description ?? "Нет названия"
        imageView.sd_setImage(with: URL(string: item.urls["regular"] ?? ""), completed: nil)
        if isLiked == true {
            likesLabel.text = "Нравится: \(item.likes! + 1)"
        } else {
            likesLabel.text = "Нравится: \(item.likes ?? 0)"
        }
        descriptionLabel.text = item.alt_description ?? "Нет описания"
    }
}
