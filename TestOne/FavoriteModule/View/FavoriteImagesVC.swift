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
        
        FavoriteManager.shared.update()
        
        favoriteCollectionView.reloadData()
        
        if FavoriteManager.shared.images == [] {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
}

//MARK: - Delegate, DataSource
extension FavoriteImagesVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavoriteManager.shared.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.configurate(image: FavoriteManager.shared.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        undateNavButtonsState()
        //        let cell = collectionView.cellForItem(at: indexPath) as! FavoriteCollectionViewCell
        //        guard let image = cell.favoriteImageView.image else { return }
        //        selectedImages.append(image)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.4, height: height * 0.4)
    }
}
