//
//  FavoriteImagesVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 21.02.2021.
//

import UIKit

class FavoriteImagesVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        favoriteCollectionView.reloadData()
        
        if FavoriteManager.shared.images == [] {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
}

//MARK: - Delegate, DataSource
extension FavoriteImagesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return FavoriteImages.shared.items.count
        return FavoriteManager.shared.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCollectionViewCell
//        cell.configurate(image: FavoriteImages.shared.items[indexPath.row])
        cell.configurate(image: FavoriteManager.shared.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        undateNavButtonsState()
        //        let cell = collectionView.cellForItem(at: indexPath) as! FavoriteCollectionViewCell
        //        guard let image = cell.favoriteImageView.image else { return }
        //        selectedImages.append(image)
    }
}
