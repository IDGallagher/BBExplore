//
//  APIService.swift
//  BBExplore
//
//  Created by Ian Gallagher on 10/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}

extension APIService: CharacterAPI {
    
    func fetchCharacters(completion: @escaping (Int?, [CharacterEntity]?) -> Void) {
        
        AF.request(Constants.apiCharacters).responseDecodable(decoder: decoder) { (response: DataResponse<[CharacterEntity], AFError>) in
            if response.value == nil {
                completion(response.response?.statusCode, nil)
            } else {
                completion(nil, response.value)
            }
        }
    }
}
