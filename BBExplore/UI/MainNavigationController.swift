//
//  MainNavigationController.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

class MainNavigationController : UINavigationController {
    
    var router: MainRouter!

    override func viewDidLoad() {
        router = MainRouter(navigationController: self)
        router.onLaunch()
    }
}
