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
            UIView.animate(withDuration: 0.6) {
                self?.tableView.alpha = 1
            }
            self?.tableView.reloadData()
        }.dispose(in: bag)
        
        presenter.searchCategories.observeNext() { [weak self] searchCategories in
            self?.searchController.searchBar.scopeButtonTitles = searchCategories?.map({$0.title}) ?? []
            self?.searchController.searchBar.selectedScopeButtonIndex = 0
        }.dispose(in: bag)
        
        tableView?.alpha = 0
        presenter.refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.hidesNavigationBarDuringPresentation = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = presenter.searchPlaceHolder
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    func registerNibs() {
        
    }
    
    func dequeueCell(for indexPath: IndexPath) -> ListItemCell? {
        assertionFailure("Should be overridden!")
        return nil
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        assertionFailure("Should be overridden!")
        return 0
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(for: indexPath)!
        cell.configure(withListItem: presenter.listItems.value![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.listItems.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.select(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow(at: indexPath)
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
