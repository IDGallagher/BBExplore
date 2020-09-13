//
//  MainNavigationController.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

class BBNavigationController : UINavigationController {
    
    var router: BBRouter!

    override func viewDidLoad() {
        router = BBRouter(navigationController: self)
        router.onLaunch()
    }
}
