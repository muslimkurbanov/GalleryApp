//
//  DetailImageVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit
import SDWebImage
import AudioToolbox
import AVFoundation

//MARK: - Protocols
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

    private var cartManager = AddToFavoriteManager.shared
    private var id: String!
    private var activityViewController: UIActivityViewController? = nil
    private var favoriteView: FavoriteImagesVC?
    
    var presenter: DetailPresenterProtocol!
    var isLiked: Bool = false { didSet {toggleImage()} }
    
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
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            FavoriteManager.shared.save(image: presenter.image)
            likesLabel.text = "Нравится: \(presenter.image.likes ?? 0 + 1)"
            
        } else {
            if !FavoriteManager.shared.images.isEmpty && presenter.image.id == id {
                
//                guard let index = FavoriteManager.shared.images.firstIndex(where: { $0.id == id }) else { return }
//                FavoriteManager.shared.images.remove(at: index)
                FavoriteManager.shared.delete(presenter: presenter, image: presenter.image)
                likesLabel.text = "Нравится: \(presenter.image.likes ?? 0)"
            } else {
                likesLabel.text = "Нравится: \(presenter.image.likes ?? 0)"
                return
            }
        }
    }
    
    //MARK: - Functions
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
        descriptionLabel.text = item.alt_description ?? "Нет описания"
        if isLiked == true {
            likesLabel.text = "Нравится: \(item.likes ?? 0 + 1)"
        } else {
            likesLabel.text = "Нравится: \(item.likes ?? 0)"
        }
    }
}
