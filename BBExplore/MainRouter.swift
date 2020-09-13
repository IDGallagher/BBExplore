//
//  MainRouter.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

protocol Router {
    func navigateTo(path: String)
    func goBack()
}

class MainRouter : Router {
    
    let navigationController: MainNavigationController
    let interactor: CharacterInteractor
    
    init(navigationController: MainNavigationController) {
        self.navigationController = navigationController
        self.interactor = CharacterInteractor(apiService: APIService())
    }
    
    func onLaunch() {
        let viewController = ListViewController.createFromStoryboard()
        viewController.presenter = CharacterListPresenter(router: self, interactor: interactor)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateTo(path: String) {
        let viewController = BBDetailViewController.createFromStoryboard()
        viewController.presenter = CharacterDetailPresenter(router: self, interactor: interactor, uid: Int(path))
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
