//
//  FavoriteScreenVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 21.02.2021.
//

import UIKit

final class FavoriteScreenVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var emptyLabel: UILabel!

    //MARK: - Properties
    
    private var activityViewController: UIActivityViewController? = nil
    private var selectedImages = [UIImage]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        FavoriteManager.shared.update()
        selectedImages.removeAll()
        collectionView.reloadData()
        
        if FavoriteManager.shared.images == [] {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
    
    //MARK: - Private funcs
    
    private func refresh() {
        
        selectedImages.removeAll()
        collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
    }
    
    //MARK: - IBActions
    
    @IBAction private func shareButton(_ sender: Any) {
        
        if selectedImages.isEmpty {
            
            let alertController = UIAlertController(title: nil, message: "Изображения не выбраны", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            self.activityViewController = UIActivityViewController(activityItems: selectedImages, applicationActivities: nil)
            //activityViewController?.excludedActivityTypes = [.saveToCameraRoll]
            
            activityViewController?.completionWithItemsHandler = { _, bool, _, _ in
                
                if bool {
                    self.refresh()
                }
            }
            present(activityViewController!, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteImagesDidTap(_ sender: Any) {
        
        guard FavoriteManager.shared.images != [] else { return }
        
        let alertController = UIAlertController(title: "Вы действительно хотите очистить избранные?", message: nil, preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Да", style: .default) { action in
            
            FavoriteManager.shared.removeAll()
            
            self.emptyLabel.isHidden = false
            self.collectionView.reloadData()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension FavoriteScreenVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return FavoriteManager.shared.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteImageCell
        
        cell.configurate(image: FavoriteManager.shared.images[indexPath.row])
        cell.contentView.isUserInteractionEnabled = false
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteScreenVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let cell = collectionView.cellForItem(at: indexPath) as! FavoriteImageCell
        
        guard let image = cell.favoriteImageView.image else { return }
        selectedImages.append(image)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! FavoriteImageCell
        guard let image = cell.favoriteImageView.image else { return }
        
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.4, height: height * 0.3)
    }
}
