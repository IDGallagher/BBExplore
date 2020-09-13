//
//  Router.swift
//  BBExplore
//
//  Created by Ian Gallagher on 13/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation

protocol Router {
    func navigateTo(path: String)
    func goBack()
}
