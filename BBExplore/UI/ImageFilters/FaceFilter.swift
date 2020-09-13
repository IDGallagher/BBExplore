//
//  FaceFilter.swift
//  BBExplore
//
//  Created by Ian Gallagher on 12/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import AlamofireImage

public struct FaceFilter: ImageFilter {
    /// Initializes the `CircleFilter` instance.
    ///
    /// - returns: The new `CircleFilter` instance.
    public init() {}

    /// The filter closure used to create the modified representation of the given image.
    public var filter: (Image) -> Image {
        { image in
            
            /// Setup
            let cImage = CIImage.init(image: image)
            let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
            
            /// Detect faces
            guard let features = detector?.features(in: cImage!)
                else {
                    return image
            }
            
            /// Find widest face rect
            guard let face = features.max(by: {$0.bounds.size.width < $1.bounds.size.width})
                else {
                    return image
            }
            
            /// Transform from CIImage coords to UIImage coords
            let transformScale = CGAffineTransform(scaleX: 1, y: -1)
            let transform = transformScale.translatedBy(x: 0, y: -cImage!.extent.height)
            
            var rect = face.bounds.applying(transform)
            rect.size.width = max(rect.size.width, rect.size.height)
            rect.size.height = rect.size.width
            
            /// Offset and inset the face
            /// Found by trial and error
            let offset = rect.size.width * 0.2
            let inset = rect.size.width * 0.3
            rect = rect.offsetBy(dx: 0, dy: -offset)
            rect = rect.insetBy(dx: -inset, dy: -inset)
            
            /// Crop the image
            UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.size.width / image.scale, height: rect.size.height / image.scale), true, 0.0)
            image.draw(at: CGPoint(x: -rect.origin.x / image.scale, y: -rect.origin.y / image.scale))
            guard let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
                else {
                    return image
            }
            UIGraphicsEndImageContext()
            return croppedImage
        }
    }
}
