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
    weak private var searchInputFild: FloatingLabelInput!
    
    weak private var viewModel: RepositorySearchModelProtocol!
    private var page = 1
    private var totalRepos = 0
    
    private var repositories = [Item](){
        didSet{
            tableView.reloadWithAnimation()
        }
    }
    
    init(withController: UIViewController, with tableView: UITableView,searchInputFild: FloatingLabelInput, viewModel: RepositorySearchModelProtocol) {
        super.init()
        
        self.controller = withController
        self.searchInputFild = searchInputFild
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.registerNib(class: RepositoryCell.self)
        
        self.viewModel = viewModel
    }
    
    func refresh(newSearch:Bool = false) {
        if newSearch {
            repositories.removeAll()
        }
        viewModel.getRepositoriesBy(text: searchInputFild.text ?? "", page: "\(page)"){ [weak self] repos in
            DispatchQueue.main.async {
                if let repos = repos {
                    self?.repositories += repos.items?.compactMap { $0 } ?? []
                    self?.totalRepos = repos.totalCount ?? 0
                }else {
                    self?.controller.openAlert(title: "Internet Connection Error!!!", message: "", closeButtonTitle: "Try again"){ [weak self] in self?.refresh()}
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.deque(RepositoryCell.self, for: indexPath)
        
        cell.configure(with: repositories[indexPath.row])
        if indexPath.row == repositories.count-5 && totalRepos > repositories.count {
            page+=1
            refresh()
        }
        return cell
    }
}

extension  RepositorySearchDataService: UITableViewDelegate {
    
    // Cell click listener
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "RepositoryDetailsViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "RepositoryDetailsViewController") as? RepositoryDetailsViewController else { return }
        
        vc.detailingRepository = { [weak self] in  return self?.repositories[indexPath.row]}
        
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}
