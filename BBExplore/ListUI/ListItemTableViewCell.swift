//
//  ListItemTableViewCell.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

class ListItemTableViewCell : UITableViewCell {
    
    @IBOutlet var label: UILabel!
    
    func configure(withListItem listItem: ListItemEntity) {
        label.text = listItem.title
    }
}
