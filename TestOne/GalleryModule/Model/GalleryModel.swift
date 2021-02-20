//
//  MainModel.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import Foundation

struct Image: Decodable {
    let urls: [URLKing.RawValue:String]
    let description: String?
    let alt_description: String?
    let likes: Int?
    let id: String?
}
enum URLKing: String {
    case raw
    case full
    case regular
    case small
    case thumb
}

