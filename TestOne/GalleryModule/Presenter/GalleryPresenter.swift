//
//  MainPresenter.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import Foundation

//MARK: - Protocol
protocol GalleryPresenterProtocol: class {
    init(view: GalleryViewProtocol)
    var images: [Image] { get set }
    func getImages()
}

class GalleryPresenter: GalleryPresenterProtocol {
    
    private weak var view: GalleryViewProtocol?
    private var networkService: GalleryNetworkServiceProtocol = GalleryNetworkService()
    private var searchResponce: [Image]? = nil
    
    var images: [Image] = []
    
    required init(view: GalleryViewProtocol) {
        self.view = view
        self.getImages()
    }
    
    //MARK: - Functions
    func getImages() {
        networkService.getImages(completion: { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let searchResponce):
                    self.searchResponce = searchResponce
                    guard let images = searchResponce else { return }
                    
                    self.images = images
                    self.view?.success()
                    
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
}
