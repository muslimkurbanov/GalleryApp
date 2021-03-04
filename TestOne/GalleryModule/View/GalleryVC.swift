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
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let cartManager = AddToFavoriteManager.shared
    
    var presenter: GalleryPresenterProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = GalleryPresenter(view: self)
        self.presenter = presenter
        
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self
    }
}

//MARK: - DataSource
extension GalleryVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.4, height: height * 0.4)
    }
}

//MARK: - Protocols
extension GalleryVC: GalleryViewProtocol {
    
    func success() {
        activityIndicator.stopAnimating()
        galleryCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
}
