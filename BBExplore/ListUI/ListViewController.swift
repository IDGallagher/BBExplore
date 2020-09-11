//
//  ListViewController.swift
//  BBExplore
//
//  Created by Ian Gallagher on 11/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class ListViewController : UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var presenter: ListPresenter!
    
    override func viewDidLoad() {
        
        registerNibs()
        configureSearchController()
        
        presenter.listItems.observeNext() { [weak self] _ in
            self?.tableView.reloadData()
        }.dispose(in: bag)
        
        presenter.searchCategories.observeNext() { [weak self] searchCategories in
            self?.searchController.searchBar.scopeButtonTitles = searchCategories?.map({$0.title}) ?? []
            self?.searchController.searchBar.selectedScopeButtonIndex = 0
        }.dispose(in: bag)
        
        presenter.refresh()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = presenter.searchPlaceHolder
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    func registerNibs() {
        tableView.register(ListItemTableViewCell.getNib(), forCellReuseIdentifier: ListItemTableViewCell.reuseIdentifier)
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.reuseIdentifier, for: indexPath) as! ListItemTableViewCell
        cell.configure(withListItem: presenter.listItems.value![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.listItems.value?.count ?? 0
    }
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.set(searchFilter: searchController.searchBar.text)
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        presenter.set(searchCategory: presenter.searchCategories.value?[selectedScope])
    }
}