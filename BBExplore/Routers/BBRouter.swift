//
//  MainRouter.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

class BBRouter : Router {
    
    let navigationController: UINavigationController
    let interactor: CharacterInteractor
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.interactor = CharacterInteractor(apiService: APIService())
    }
    
    func onLaunch() {
        let viewController = BBListViewController.createFromStoryboard()
        viewController.presenter = CharacterListPresenter(router: self, interactor: interactor)
        navigationController.pushViewController(viewController, animated: false)
    }
     
    /// Generally in a more complex app, path could be a path url to be parsed to specify the navigation path. However here it is always just the character ID
    func navigateTo(path: String) {
        let viewController = BBDetailViewController.createFromStoryboard()
        viewController.presenter = CharacterDetailPresenter(router: self, interactor: interactor, uid: Int(path))
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
