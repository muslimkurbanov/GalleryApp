//
//  ProfileScreenPresenter.swift
//  TestOne
//
//  Created by Муслим Курбанов on 07.07.2021.
//

import Foundation

protocol ProfileScreenViewOutput: BaseViewOutput {
    
}

final class ProfileScreenPresenter {
    
    private unowned var view: ProfileScreenViewInput
    
    init(view: ProfileScreenViewInput) {
        self.view = view
    }
}

extension ProfileScreenPresenter: ProfileScreenViewOutput {
    
    func viewIsReady() {
        print("test")
    }
}
