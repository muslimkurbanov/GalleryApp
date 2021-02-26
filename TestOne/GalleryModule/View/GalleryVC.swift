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
    
    fileprivate var cart = Cart()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Способ для создания презентера из вью конроллера
        let presenter = GalleryPresenter(view: self)
        self.presenter = presenter

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
        guard let favVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "favoriteVC") as? FavoriteImagesVC else { return }
        
        let presenter = DetailPresenter(view: vc, images: item, isLiked: isLiked)
        vc.presenter = presenter
        vc.delegate = self
        
        
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

extension GalleryVC: DetailViewDelegate {
    func addToFavorite(cell: GalleryCVCell) {
        guard let indexPath = galleryCV.indexPath(for: cell) else { return }

        let product = presenter.images[indexPath.row]
        
        cart.updateCart(with: product)
        
    }
    
    
}
