//
//  CharacterListPresenter.swift
//  BBExplore
//
//  Created by Ian Gallagher on 10/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

public class CharacterListPresenter : ListPresenter {
    
    let bag = DisposeBag()
    let interactor: CharacterInteractor
    let router: Router?
    
    private(set) var listItems = Observable<[ListItemEntity]?>(nil)
    private(set) var isRefreshing = Observable<Bool>(false)
    private(set) var searchCategories = Observable<[SearchCategoryEntity]?>([])
    private(set) var searchPlaceHolder: String = "Search Characters"
    
    private var searchFilter = Observable<String?>(nil)
    private var searchCategory = Observable<SearchCategoryEntity?>(nil)
    
    init(router: Router?, interactor: CharacterInteractor) {
        
        self.interactor = interactor
        self.router = router
        
        interactor.characters.observeNext() { [weak self] characters in
            self?.searchCategories.send(self?.createSearchCategories(fromCharacters: characters))
            self?.listItems.send(self?.createListItems(fromCharacters: characters))
        }.dispose(in: bag)
        
        interactor.isRefreshing.observeNext() { [weak self] isRefreshing in
            self?.isRefreshing.send(isRefreshing)
        }.dispose(in: bag)
        
        searchFilter.combineLatest(with: searchCategory).observeNext() { [weak self] _ in
            self?.listItems.send(self?.createListItems(fromCharacters: interactor.characters.value))
        }.dispose(in: bag)
    }
    
    private func createSearchCategories(fromCharacters characters: [CharacterEntity]?) -> [SearchCategoryEntity]? {
        guard let characters = characters else { return nil }
        
        var searchCategories: [SearchCategoryEntity] = [SearchCategoryEntity(uid: nil, title: "All")]
        for character in characters {
            for season in character.appearance {
                if !searchCategories.contains(where: {$0.uid == season}) {
                    searchCategories.append(SearchCategoryEntity(uid: season, title: "S\(season)"))
                }
            }
        }
        return searchCategories
    }
    
    private func createListItems(fromCharacters characters: [CharacterEntity]?) -> [ListItemEntity]? {
        let filteredCharacters = characters?.filter({
            $0.appearance.count > 0
                && (searchFilter.value == nil || searchFilter.value == "" || $0.name.lowercased().contains(searchFilter.value!.lowercased()))
                && (searchCategory.value?.uid == nil || $0.appearance.contains(searchCategory.value!.uid!))
        })
        return filteredCharacters?.map({listItem(fromCharacter: $0)})
    }
    
    private func listItem(fromCharacter character: CharacterEntity) -> ListItemEntity {
        return ListItemEntity(uid: character.charId, title: character.name, imageURL: character.img)
    }
    
    func refresh() {
        interactor.refresh()
    }
    
    func set(searchFilter: String?) {
        self.searchFilter.send(searchFilter)
    }
    
    func set(searchCategory: SearchCategoryEntity?) {
        self.searchCategory.send(searchCategory)
    }
    
    func select(index: Int) {
        guard
            let listItems = listItems.value,
            listItems.count > index
            else {
                return
        }
        router?.navigateTo(path: "\(listItems[index].uid)")
    }
}
