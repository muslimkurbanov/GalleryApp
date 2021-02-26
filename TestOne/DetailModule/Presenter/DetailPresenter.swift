//
//  DetailPresenter.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol: class {
    init(view: DetailViewProtocol, images: Image, isLiked: Bool)
    func setImages()
    var isLiked: Bool { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    
    
    private weak var view: DetailViewProtocol?
    private var networkService: GalleryNetworkServiceProtocol = GalleryNetworkService()
    private var searchResponce: [Image]? = nil
    
    var isLiked: Bool
    var images: Image
    
    required init(view: DetailViewProtocol, images: Image, isLiked: Bool) {
        self.view = view
        self.images = images
        self.isLiked = isLiked
     }
    
    func setImages() {
        print("simpleSetImages")
        self.view?.setImages(item: images, isLiked: isLiked)
    }

    
}
