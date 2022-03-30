//
//  RepositorySearchDataService.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 30.03.22.
//

import UIKit

class RepositorySearchDataService: NSObject, UITableViewDataSource {
    weak private var controller: UIViewController!
    weak private var tableView: UITableView!
    
    weak private var viewModel: RepositorySearchModelProtocol!
    
    init(withController: UIViewController, with tableView: UITableView, viewModel: RepositorySearchModelProtocol) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
       // self.tableView.isPagingEnabled = true
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.registerNib(class: RepositoryCell.self)
        
        self.viewModel = viewModel
    }
    
    func refresh() {
       // pages = viewModel.getPages()
        tableView.reloadData()
       // startTimer()
        viewModel.getRepositoriesBy(text: "tic-tac-toe-ios-multiplayer-game"){ [weak self] repos in
            print(repos)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.deque(RepositoryCell.self, for: indexPath)
        
        //cell.configure(with: cryptos[indexPath.row])
        
        return cell
    }
}

extension  RepositorySearchDataService: UITableViewDelegate {
    
    // Cell click listener
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
