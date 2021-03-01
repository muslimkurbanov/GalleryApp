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
    init(view: DetailViewProtocol, images: Image, isLiked: Bool, cell: Int)
    func setImages()
    var isLiked: Bool { get set }
    var images: Image { get set }
    var cell: Int { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    
    private weak var view: DetailViewProtocol?
    private var networkService: GalleryNetworkServiceProtocol = GalleryNetworkService()
    private var searchResponce: [Image]? = nil
    
    var isLiked: Bool
    var images: Image
    var cell: Int
    
    required init(view: DetailViewProtocol, images: Image, isLiked: Bool, cell: Int) {
        self.view = view
        self.images = images
        self.isLiked = isLiked
        self.cell = cell
     }
    
    //MARK: - Functions
    func setImages() {
        self.view?.setImages(item: images, isLiked: isLiked)
    }
}
