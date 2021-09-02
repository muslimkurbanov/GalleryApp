//
//  ImageDetailScreenPresenter.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    
    init(view: DetailViewProtocol, images: Image, isLiked: Bool)
    
    func setImages()
    func addToFavorite(isLiked: Bool, id: String)
    
    var isLiked: Bool { get set }
    var image: Image { get set }
}

final class ImageDetailScreenPresenter {
    
    //MARK: - Properties
    
    private weak var view: DetailViewProtocol?
    private var networkService: GalleryNetworkServiceProtocol = GalleryNetworkService()
    private var searchResponce: [Image]? = nil
    
    var image: Image
    var isLiked: Bool {
        didSet {
            self.view?.toggleImage()
        }
    }
    
    //MARK: - Init
    
    required init(view: DetailViewProtocol, images: Image, isLiked: Bool) {
        self.view = view
        self.image = images
        self.isLiked = isLiked
    }
}

//MARK: - DetailPresenterProtocol

extension ImageDetailScreenPresenter: DetailPresenterProtocol {
    
    func setImages() {
        
        self.view?.setImages(item: image, isLiked: isLiked)
    }
    
    func addToFavorite(isLiked: Bool, id: String) {
        
        let change = AddToFavoriteManager.shared.selectFavorite(by: id)
        self.isLiked = change
        
        if self.isLiked {
            FavoriteManager.shared.save(image: image)
        } else {
            FavoriteManager.shared.delete(presenter: self, image: image)
        }
        self.view?.updateCountOfLikes()
    }
}
