//
//  RepositorySearchViewController.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 30.03.22.
//

import UIKit

class RepositorySearchViewController: UIViewController {
    @IBOutlet weak private var searchInputFild: FloatingLabelInput!
    @IBOutlet weak private var tableView: UITableView!
    
    private var viewModel: RepositorySearchModelProtocol!
    private var repositorySearchDataService: RepositorySearchDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }
    private func configureDataSource() {
        unowned let vc = self
        
        viewModel = RepositorySearchModel()
        repositorySearchDataService = RepositorySearchDataService(withController: vc, with: tableView,searchInputFild: searchInputFild, viewModel: viewModel)
    
        repositorySearchDataService.refresh()
    }
    
    @IBAction func searchButtonOnClick(_ sender: Any) {
        repositorySearchDataService.refresh(newSearch: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        repositorySearchDataService.refresh()
    }

}
