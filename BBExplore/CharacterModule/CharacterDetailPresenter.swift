//
//  CharacterDetailPresenter.swift
//  BBExplore
//
//  Created by Ian Gallagher on 13/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

class CharacterDetailPresenter {
    
    let bag = DisposeBag()
    let router: Router
    let interactor: CharacterInteractor
    
    private var uid = Observable<Int?>(nil)
    private(set) var character = Observable<CharacterEntity?>(nil)
    
    init(router: Router, interactor: CharacterInteractor, uid: Int?) {
        
        self.router = router
        self.interactor = interactor
    
        self.uid.send(uid)
        
        interactor.characters.combineLatest(with: self.uid).observeNext() { [weak self] (_, uid) in
            self?.character.send(self?.getCharacterFor(uid: uid))
        }.dispose(in: bag)
    }
    
    private func getCharacterFor(uid: Int?) -> CharacterEntity? {
        return interactor.characters.value?.first(where: {$0.charId == uid})
    }
    
    func backButtonPressed() {
        router.goBack()
    }
}
