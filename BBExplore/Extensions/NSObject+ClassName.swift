//
//  NSObject+ClassName.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// Gets the class name of any subclass of NSObject
    func className() -> String {
        let name = NSStringFromClass(type(of: self))
        let array = name.components(separatedBy: ".")
        if array.count > 1 {
            return array[1]
        } else {
            return name
        }
    }
    
    static func className() -> String {
        let name = NSStringFromClass(self)
        let array = name.components(separatedBy: ".")
        if array.count > 1 {
            return array[1]
        } else {
            return name
        }
    }
}
