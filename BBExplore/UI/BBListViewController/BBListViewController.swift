//
//  BBListViewController.swift
//  BBExplore
//
//  Created by Ian Gallagher on 13/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit

class BBListViewController : ListViewController {
    
    override func registerNibs() {
        tableView?.register(BBTableViewCell.getNib(), forCellReuseIdentifier: BBTableViewCell.reuseIdentifier)
    }
    
    override func dequeueCell(for indexPath: IndexPath) -> ListItemCell {
        return tableView.dequeueReusableCell(withIdentifier: BBTableViewCell.reuseIdentifier, for: indexPath) as! BBTableViewCell
    }
    
    override func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}


