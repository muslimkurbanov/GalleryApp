//
//  FavoriteImagesVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 21.02.2021.
//

import UIKit



class FavoriteImagesVC: UIViewController {
    
//    static var shared = FavoriteImagesVC()
    //MARK: - IBOutlets
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var presenter: FavoriteImagesPresenterProtocol!
    
    
    var favoriteImages = [UIImage]() {
        didSet {
            favoriteCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = DetailImageVC()
        vc.favoriteDelegare = self
//        self.favoriteImages.append(Test.shared.image!)
//        self.delegate = self
//        self.delegate?.append(image: Test.shared.image!)
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
}

extension FavoriteImagesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(favoriteImages.count)
        return favoriteImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        
        let item = favoriteImages[indexPath.row]
        cell.configurate(image: item)
        
        return cell
    }
}

extension FavoriteImagesVC: FavoriteDelegate {
    func append(image: UIImage) {
        favoriteImages.append(Test.shared.image!)
        favoriteCollectionView.reloadData()
        print("append")
    }
    
}
