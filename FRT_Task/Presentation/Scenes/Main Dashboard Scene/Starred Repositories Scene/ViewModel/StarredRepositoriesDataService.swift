//
//  StarredRepositoriesDataService.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 01.04.22.
//

import UIKit

class StarredRepositoriesDataService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak private var controller: UIViewController!
    weak private var tableView: UITableView!
    
    weak private var viewModel: StarredRepositoriesModelProtocol!
    
    private var repositories = [Item](){
        didSet{
            tableView.reloadWithAnimation()
        }
    }
    
    init(withController: UIViewController, with tableView: UITableView, viewModel: StarredRepositoriesModelProtocol) {
        super.init()
        
        self.controller = withController
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.registerNib(class: RepositoryCell.self)
        
        self.viewModel = viewModel
    }
    
    func refresh() {
        repositories.removeAll()
        repositories += FavoriteCoreDataManager.shared.tryFetchAllFavorites()
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.deque(RepositoryCell.self, for: indexPath)
        
        cell.configure(with: repositories[indexPath.row])
        
        return cell
    }
    
    // Cell click listener
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "RepositoryDetailsViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "RepositoryDetailsViewController") as? RepositoryDetailsViewController else { return }
        
        vc.detailingRepository = { [weak self] in  return self?.repositories[indexPath.row]}
        
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}

