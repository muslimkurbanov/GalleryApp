//
//  DetailPresenter.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import Foundation
import UIKit

//MARK: - Protocol
protocol DetailPresenterProtocol: class {
    init(view: DetailViewProtocol, images: Image, isLiked: Bool)
    func setImages()
    var isLiked: Bool { get set }
    var image: Image { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    
    private weak var view: DetailViewProtocol?
    private var networkService: GalleryNetworkServiceProtocol = GalleryNetworkService()
    private var searchResponce: [Image]? = nil
    
    var isLiked: Bool
    var image: Image
    
    required init(view: DetailViewProtocol, images: Image, isLiked: Bool) {
        self.view = view
        self.image = images
        self.isLiked = isLiked
     }
    
    //MARK: - Functions
    func setImages() {
        self.view?.setImages(item: image, isLiked: isLiked)
    }
    
    func change() {
        print("change")
        self.view?.update()
    }
    
    
}
