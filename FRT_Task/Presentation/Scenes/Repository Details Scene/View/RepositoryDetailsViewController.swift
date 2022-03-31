//
//  RepositoryDetailsViewController.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 31.03.22.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    @IBOutlet weak private var dataLabel: UILabel!
    @IBOutlet weak private var languageLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    var detailingRepository: (() -> Item?)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }
    
    private func configureDataSource() {
        guard let repo = detailingRepository?() else { dismiss(animated: true, completion: nil); return}
        
        dataLabel.text =  String(repo.createdAt?.split(separator: "T").first ?? "")
        languageLabel.text = repo.language ?? "TXT"
        descriptionLabel.text = repo.itemDescription ??  "No Description"
    }
    @IBAction func onOpenLinkClick(_ sender: Any) {
        guard let repo = detailingRepository?() else { dismiss(animated: true, completion: nil); return}
        if let url = URL(string: repo.htmlURL ?? ""), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func onStarRepositoryClick(_ sender: Any) {
        FavoriteCoreDataManager.shared.saveFavorite(info: (detailingRepository?())!)
       print( FavoriteCoreDataManager.shared.tryFetchAllFavorites())
    }
    
}
