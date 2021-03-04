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
    func updateCountOfLikes()
    func toggleImage()
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
        presenter.addToFavorite(isLiked: isLiked, id: id)
    }
}

//MARK: - DetailViewProtocol
extension DetailImageVC: DetailViewProtocol {
    
    func toggleImage() {
        let imageName = presenter.isLiked ? "filHeart" : "heart"
        addToFavorite.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func updateCountOfLikes() {
        if presenter.isLiked {
            likesLabel.text = "Нравится: \((presenter.image.likes ?? 0) + 1)"
            
        } else {
            likesLabel.text = "Нравится: \(presenter.image.likes ?? 0)"
        }
    }
    
    func setImages(item: Image, isLiked: Bool) {
        print("setImages")
        self.id = item.id
        nameLabel.text = item.description ?? "Нет названия"
        imageView.sd_setImage(with: URL(string: item.urls["regular"] ?? ""), completed: nil)
        descriptionLabel.text = item.alt_description ?? "Нет описания"
        if presenter.isLiked == true {
            likesLabel.text = "Нравится: \((item.likes ?? 0) + 1)"
        } else {
            likesLabel.text = "Нравится: \(item.likes ?? 0)"
        }
    }
}
