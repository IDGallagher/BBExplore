//
//  CharacterEntity.swift
//  BBExplore
//
//  Created by Ian Gallagher on 09/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation

struct CharacterEntity : Decodable {
    let charId: Int
    let name: String
    let img: String
    let occupation: [String]
    let status: String
    let nickname: String
    let appearance: [Int]
}
