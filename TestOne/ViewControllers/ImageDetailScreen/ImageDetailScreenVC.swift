//
//  ImageDetailScreenVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit
import SDWebImage
import SkeletonView

protocol DetailViewProtocol: AnyObject {
    func setImages(item: Image, isLiked: Bool)
    func updateCountOfLikes()
    func toggleImage()
}

final class ImageDetailScreenVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var addToFavorite: UIButton!
    
    //MARK: - Properties
    
    private var cartManager = AddToFavoriteManager.shared
    private var id: String!
    private var activityViewController: UIActivityViewController? = nil
    private var favoriteView: FavoriteScreenVC?
    
    var presenter: DetailPresenterProtocol!
    var isLiked: Bool = false { didSet {toggleImage()} }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentSize = CGSize(width: 375, height: 1000)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.setImages()
        isLiked = presenter.isLiked
    }
    
    //MARK: - IBActions
    
    @IBAction private func shareImage(_ sender: Any) {
        
        let image = self.imageView.image
        self.activityViewController = UIActivityViewController(activityItems: [image ?? []], applicationActivities: nil)
        
        self.present(self.activityViewController!, animated: true, completion: nil)
    }
    
    @IBAction private func addToFavorite(_ sender: Any) {
        
        presenter.addToFavorite(isLiked: isLiked, id: id)

        if presenter.isLiked == true {
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            let alert = UIAlertController(title: "Добавлено в избранное", message: nil, preferredStyle: .alert)
            
            present(alert, animated: true)
                
            
            let when = DispatchTime.now() + 1
            
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

//MARK: - DetailViewProtocol

extension ImageDetailScreenVC: DetailViewProtocol {
    
    func toggleImage() {
        let imageName = presenter.isLiked ? "filHeart" : "heart"
        addToFavorite.setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
    
    func updateCountOfLikes() {
        if presenter.isLiked {
            likesLabel.text = "Нравится: \((presenter.image.likes ?? 0) + 1)"
        } else {
            likesLabel.text = "Нравится: \(presenter.image.likes ?? 0)"
        }
    }
    
    func setImages(item: Image, isLiked: Bool) {
        self.id = item.id
        nameLabel.text = item.description ?? "Нет названия"
        imageView.sd_imageTransition = .fade
//        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.isSkeletonable = true
        imageView.showAnimatedSkeleton()
        imageView.isUserInteractionEnabled = true
//        imageView.startSkeletonAnimation()

        imageView.sd_setImage(with: URL(string: item.urls["regular"] ?? ""), completed: {_,_,_,_ in
            self.imageView.stopSkeletonAnimation()
            self.imageView.hideSkeleton()
        })
        descriptionLabel.text = item.alt_description ?? "Нет описания"
        if presenter.isLiked == true {
            likesLabel.text = "Нравится: \((item.likes ?? 0) + 1)"
        } else {
            likesLabel.text = "Нравится: \(item.likes ?? 0)"
        }
    }
}
