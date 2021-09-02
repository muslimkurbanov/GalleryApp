//
//  ProfileScreenVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 07.07.2021.
//

import UIKit

protocol ProfileScreenViewInput: AnyObject {
    
}

class ProfileScreenVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ProfileScreenViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = ProfileScreenPresenter(view: self)
        self.presenter = presenter
        self.presenter?.viewIsReady()
    }
}

extension ProfileScreenVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ProfileScreenModel.names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileScreenCell", for: indexPath) as! ProfileScreenProductCell
        
        cell.configurate(name: ProfileScreenModel.names[indexPath.row])
        
        return cell
    }
}

extension ProfileScreenVC: ProfileScreenViewInput {
    
}
