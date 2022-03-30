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
    private var ballanceDataService: RepositorySearchDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        // Do any additional setup after loading the view.  
    }
    private func configureDataSource() {
        unowned let vc = self
        
        viewModel = RepositorySearchModel()
        ballanceDataService = RepositorySearchDataService(withController: vc, with: tableView, viewModel: viewModel)
    
        ballanceDataService.refresh()
    }
    
    
    @IBAction func searchButtonOnClick(_ sender: Any) {
    
    }

}
