//
//  ListPresenter.swift
//  BBExplore
//
//  Created by Ian Gallagher on 10/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation
import Bond

/// A presenter that provides a list of ListItemEntities. This list can be filtered and an individual item can be selected
protocol ListPresenter {
    var listItems: Observable<[ListItemEntity]?> {get}
    var isRefreshing: Observable<Bool> {get}
    var searchCategories: Observable<[SearchCategoryEntity]?> {get}
    
    var searchPlaceHolder: String {get}
    func refresh()
    func set(searchFilter: String?)
    func set(searchCategory: SearchCategoryEntity?)
    func select(index: Int)
}
