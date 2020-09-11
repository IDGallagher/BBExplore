//
//  UITableViewCell+Nib.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    class func getNib() -> UINib {
        return UINib(nibName: className(), bundle: nil)
    }
    
    class var reuseIdentifier: String {
        return className()
    }
}
