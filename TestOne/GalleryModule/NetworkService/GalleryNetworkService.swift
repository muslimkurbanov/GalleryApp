//
//  GalleryNetworkService.swift
//  TestOne
//
//  Created by Муслим Курбанов on 20.02.2021.
//

import Foundation
import Alamofire

protocol GalleryNetworkServiceProtocol {
    func getImages(completion: @escaping (Result<[Image]?, Error>) -> Void)
}

class GalleryNetworkService: GalleryNetworkServiceProtocol {
    func getImages(completion: @escaping (Result<[Image]?, Error>) -> Void) {
        let urlString = "https://api.unsplash.com/photos/?client_id=F8HtKWZy9TjdMlE8v_Zuh1xKJF3x-5jvL3f7tnECdJE"
        
        AF.request(urlString, method: .get, parameters: nil).responseJSON { (responce) in
            switch responce.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                if let arrayDictionary = value as? [[String: Any]] {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: arrayDictionary, options: .fragmentsAllowed)
                        let result = try JSONDecoder().decode([Image].self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
