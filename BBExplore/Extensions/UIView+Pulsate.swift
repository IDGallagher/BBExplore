//
//  UIView+Shake.swift
//  BBExplore
//
//  Created by Ian Gallagher on 13/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

extension UIView {
    func pulsate() {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.duration = 0.2
        animation.repeatCount = 3
        animation.autoreverses = true
        
        animation.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1))
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeScale(0.92, 0.92, 1))
        self.layer.add(animation, forKey: "transform")
    }
}
