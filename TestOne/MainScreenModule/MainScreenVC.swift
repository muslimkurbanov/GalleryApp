//
//  MainScreenVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit

class MainScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func pushToGallery(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "galleryVC") as? GalleryVC else { return }
        let presenter = GalleryPresenter(view: vc)
        vc.presenter = presenter
        navigationController?.pushViewController(vc, animated: true)
    }
}
