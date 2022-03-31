//
//  StarredRepositoriesViewController.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 30.03.22.
//

import UIKit

class StarredRepositoriesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    private var viewModel: StarredRepositoriesModelProtocol!
    private var starredRepositoriesDataService: StarredRepositoriesDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        // Do any additional setup after loading the view.  StarredRepositoriesModelProtocol
    }
    
    private func configureDataSource() {
        unowned let vc = self
        
        viewModel = StarredRepositoriesModel()
        starredRepositoriesDataService = StarredRepositoriesDataService(withController: vc, with: tableView, viewModel: viewModel)
    
        starredRepositoriesDataService.refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        starredRepositoriesDataService.refresh()
    }

}
