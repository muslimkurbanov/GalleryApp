//
//  DetailImageVC.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import UIKit
import SDWebImage

protocol DetailViewProtocol: class {
    func setImages(item: Image)
}

class DetailImageVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var activityViewController: UIActivityViewController? = nil
    var presenter: DetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setImages()
    }
    
    
    @IBAction func shareImage(_ sender: Any) {
        let image = self.imageView.image
        
        self.activityViewController = UIActivityViewController(activityItems: [image ?? []], applicationActivities: nil)
        self.present(self.activityViewController!, animated: true, completion: nil)
    }
    
}

extension DetailImageVC: DetailViewProtocol {
    func setImages(item: Image) {
        nameLabel.text = item.description ?? "Нет названия"
        imageView.sd_setImage(with: URL(string: item.urls["regular"] ?? ""), completed: nil)
        likesLabel.text = "Нравится: \(item.likes ?? 0)"
        descriptionLabel.text = item.alt_description ?? "Нет описания"
    }
    
}
