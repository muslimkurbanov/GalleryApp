//
//  DetailPresenter.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import Foundation

protocol DetailPresenterProtocol: class {
    init(view: DetailViewProtocol, images: Image)
    func setImages()
}

class DetailPresenter: DetailPresenterProtocol {
    
    private weak var view: DetailViewProtocol?
    private var networkService: GalleryNetworkServiceProtocol = GalleryNetworkService()
    private var searchResponce: [Image]? = nil

    var images: Image
    
    required init(view: DetailViewProtocol, images: Image) {
        self.view = view
        self.images = images
    }
    
    func setImages() {
        self.view?.setImages(item: images)
    }
    
    
}
