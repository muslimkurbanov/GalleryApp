//
//  ViewController.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit

protocol GalleryViewProtocol: class {
    func success()
    func failure(error: Error)
}

class GalleryVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var galleryCV: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let cartManager = FavoriteManager.shared
    var presenter: GalleryPresenterProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.galleryCV.delegate = self
        self.galleryCV.dataSource = self
    }

}

//MARK: - DataSource
extension GalleryVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! GalleryCVCell
        let item = presenter.images[indexPath.row]
        cell.configurate(model: item)
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = presenter.images[indexPath.row]
        let isLiked = cartManager.isAddedToFavorite(item.id ?? "")
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as? DetailImageVC else { return }
        let presenter = DetailPresenter(view: vc, images: item, isLiked: isLiked)
        vc.presenter = presenter
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Protocol
extension GalleryVC: GalleryViewProtocol {
    
    func success() {
        activityIndicator.stopAnimating()
        galleryCV.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
}

