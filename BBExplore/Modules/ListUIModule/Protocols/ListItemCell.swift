//
//  ListItemCell.swift
//  BBExplore
//
//  Created by Ian Gallagher on 13/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

protocol ListItemCell : UITableViewCell {
    func configure(withListItem: ListItemEntity)
}
