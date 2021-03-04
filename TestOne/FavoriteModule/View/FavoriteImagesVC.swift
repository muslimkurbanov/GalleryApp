//
//  FavoriteImagesVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 21.02.2021.
//

import UIKit

class FavoriteImagesVC: UIViewController {
    
    static var shared = FavoriteImagesVC()
    
    //MARK: - IBOutlets
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!

    private var activityViewController: UIActivityViewController? = nil
    var selectedImages = [UIImage]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.allowsMultipleSelection = true
        favoriteCollectionView.contentInsetAdjustmentBehavior = .automatic
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
    
    //MARK: - IBActions
    @IBAction func shareButton(_ sender: Any) {
        
        if selectedImages.isEmpty {
            let alertController = UIAlertController(title: nil, message: "Изображения не выбраны", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.activityViewController = UIActivityViewController(activityItems: selectedImages, applicationActivities: nil)
            activityViewController?.completionWithItemsHandler = { _, bool, _, _ in
                if bool {
                    self.refresh()
                }
            }
            self.present(self.activityViewController!, animated: true, completion: nil)
        }
    }
    
    func refresh() {
        self.selectedImages.removeAll()
        self.favoriteCollectionView.selectItem(at: nil, animated: true, scrollPosition: [])
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
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FavoriteCollectionViewCell
        guard let image = cell.favoriteImageView.image else { return }
        selectedImages.append(image)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FavoriteCollectionViewCell
        guard let image = cell.favoriteImageView.image else { return }
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.4, height: height * 0.4)
    }
}
