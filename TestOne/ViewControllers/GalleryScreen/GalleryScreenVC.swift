//
//  GalleryScreenVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit

protocol GalleryViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

final class GalleryScreenVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet private weak var galleryCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let addToFavoriteManager = AddToFavoriteManager.shared
    
    var presenter: GalleryPresenterProtocol!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = GalleryScreenPresenter(view: self)
        self.presenter = presenter
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDataSource

extension GalleryScreenVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! GalleryImageCell
        let item = presenter.images[indexPath.row]
        cell.configurate(model: item)
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension GalleryScreenVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = presenter.images[indexPath.row]
        let isLiked = addToFavoriteManager.isAddedToFavorite(item.id ?? "")
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as? ImageDetailScreenVC else { return }
        let presenter = ImageDetailScreenPresenter(view: vc, images: item, isLiked: isLiked)
        vc.presenter = presenter
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.4, height: height * 0.3)
    }
}

//MARK: - GalleryViewProtocol

extension GalleryScreenVC: GalleryViewProtocol {
    
    func success() {
        activityIndicator.stopAnimating()
        galleryCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        
        //TODO: - Вернуть алерт
//        showAlert(title: "Произошла ошибка", message: error.localizedDescription)
    }
}
