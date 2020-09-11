//
//  MainRouter.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

class MainRouter {
    
    let navigationController: MainNavigationController
    let apiService: APIService
    
    init(navigationController: MainNavigationController) {
        self.navigationController = navigationController
        self.apiService = APIService()
    }
    
    func onLaunch() {
        let viewController = ListViewController.createFromStoryboard()
        let interactor = CharacterInteractor(apiService: apiService)
        viewController.presenter = CharacterListPresenter(interactor: interactor)
        navigationController.pushViewController(viewController, animated: false)
    }
    
}
