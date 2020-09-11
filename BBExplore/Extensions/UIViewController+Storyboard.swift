//
//  UIViewController+Storyboard.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

extension UIViewController {

    /// Creates a new instance of a view controller from its storyboard. Return type is whatever subclass of UIViewController you're trying to create
    /// NB: Assumes that the view controller has a storyboard with the same name and it is set as the initial view controller in that storyboard
    class func createFromStoryboard() -> Self {
        return _createFromStoryboard()
    }
    
    private class func _createFromStoryboard<T>() -> T {
        let storyboard = UIStoryboard(name: className(), bundle: nil)
        return storyboard.instantiateInitialViewController() as! T
    }
}
