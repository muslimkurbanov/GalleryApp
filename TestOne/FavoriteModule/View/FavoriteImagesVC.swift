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

    let cartManager = FavoriteManager.shared

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
                
        favoriteCollectionView.reloadData()
        if FavoriteImages.shared.items == [] {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
}

//MARK: - Delegate, DataSource
extension FavoriteImagesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavoriteImages.shared.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.configurate(image: FavoriteImages.shared.items[indexPath.row])
        return cell
    }
    
}

