//
//  BBDetailViewController.swift
//  BBExplore
//
//  Created by Ian Gallagher on 13/09/2020.
//  Copyright © 2020 IGProjects. All rights reserved.
//

import UIKit
import AlamofireImage
import Bond
import ReactiveKit

class BBDetailViewController : UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var occupationLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var appearanceLabel: UILabel!
    
    var presenter: CharacterDetailPresenter!
    
    override func viewDidLoad() {
        presenter.character.observeNext() { [weak self] character in
            self?.configureWith(character: character)
        }.dispose(in: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configureWith(character: CharacterEntity?) {
        guard let character = character else { return }
        let url = URL(string: character.img)!
        imageView.af.setImage(withURL: url, runImageTransitionIfCached: false)
        
        nameLabel.text = character.name
        nicknameLabel.text = "aka \(character.nickname)"
        let occupations = character.occupation.joined(separator: ", ")
        occupationLabel.text = "Occupation: \(occupations)"
        let appearances = character.appearance.map({"S\($0)"}).joined(separator: ", ")
        appearanceLabel.text = "Appearances: \(appearances)"
        statusLabel.text = "Status: \(character.status)"
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        presenter.backButtonPressed()
    }
}
