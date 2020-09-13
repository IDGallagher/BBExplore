//
//  ListItemTableViewCell.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit
import AlamofireImage

class ListItemTableViewCell : UITableViewCell {
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var itemImage: UIImageView!
    
    func configure(withListItem listItem: ListItemEntity) {
        itemLabel.text = listItem.title
        
        let url = URL(string: listItem.imageURL)!
        let filter = CircleFaceFilter(size: CGSize(width: 88.0, height: 88.0))
//        let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 88.0, height: 88.0))
        itemImage.af.setImage(withURL: url, filter: filter, imageTransition: .crossDissolve(0.6), runImageTransitionIfCached: false)
    }
    
    override func prepareForReuse() {
        itemImage.af.cancelImageRequest()
        itemImage.image = nil
    }
}
