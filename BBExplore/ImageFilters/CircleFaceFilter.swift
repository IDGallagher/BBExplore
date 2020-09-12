//
//  CircleFaceFilter.swift
//  BBExplore
//
//  Created by Ian Gallagher on 12/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import AlamofireImage

public struct CircleFaceFilter: CompositeImageFilter {
    /// Initializes the `AspectScaledToFillSizeCircleFilter` instance with the given size.
    ///
    /// - parameter size: The size.
    ///
    /// - returns: The new `AspectScaledToFillSizeCircleFilter` instance.
    public init(size: CGSize) {
        filters = [FaceFilter(), AspectScaledToFillSizeFilter(size: size), CircleFilter()]
    }

    /// The image filters to apply to the image in sequential order.
    public let filters: [ImageFilter]
}
