//
//  CharacterInteractor.swift
//  BBExplore
//
//  Created by Ian Gallagher on 09/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation
import Bond

protocol CharacterAPI {
    func fetchCharacters(completion: @escaping (Int?, [CharacterEntity]?) -> Void)
}

class CharacterInteractor {
    
    private let apiService: CharacterAPI
    
    private(set) var characters = Observable<[CharacterEntity]?>(nil)
    private(set) var isRefreshing = Observable<Bool>(false)
    private(set) var statusError = Observable<Int?>(nil)
    
    init(apiService: CharacterAPI) {
        self.apiService = apiService
    }
    
    func refresh() {
        isRefreshing.send(true)
        apiService.fetchCharacters(){ [weak self] statusCode, characters in
            if characters == nil {
                self?.statusError.send(statusCode)
            } else {
                /// Local Store?
            }
            self?.characters.send(characters)
            self?.isRefreshing.send(false)
        }
    }
}


