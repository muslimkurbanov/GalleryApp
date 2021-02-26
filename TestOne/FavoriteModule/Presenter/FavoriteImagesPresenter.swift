//
//  FavoriteImagesPresenter.swift
//  TestOne
//
//  Created by Муслим Курбанов on 21.02.2021.
//

import Foundation
import UIKit

protocol FavoriteImagesPresenterProtocol: class {
    init(view: FavoriteDelegate)

}

class FavoriteImagesPresenter: FavoriteImagesPresenterProtocol {

    private weak var view: FavoriteDelegate?
    private var searchResponce: [UIImage]? = nil


    required init(view: FavoriteDelegate) {
        self.view = view
    }
    
//    func append(image: UIImage) {
//        view?.append(image: image)
//    }


}
