//
//  GalleryScreenModel.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import Foundation

struct Image: Codable, Equatable {
    var urls: [String:String]
    var description: String?
    var alt_description: String?
    var likes: Int?
    var id: String?
}

enum URLKing: String {
    case raw
    case full
    case regular
    case small
    case thumb
}

