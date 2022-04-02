//
//  RepositorySearchDataService.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 30.03.22.
//

import UIKit
import SkeletonView

class RepositorySearchDataService: NSObject, SkeletonTableViewDataSource {
    weak private var controller: UIViewController!
    weak private var tableView: UITableView!
    weak private var searchInputFild: FloatingLabelInput!
    
    weak private var viewModel: RepositorySearchModelProtocol!
    private var page = 1
    private var totalRepos = 0
    
    private var repositories = [Item](){
        didSet{
            tableView.stopSkeletonAnimation()
            tableView.hideSkeleton()
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
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60
        
        self.viewModel = viewModel
    }
    
    func refresh(newSearch:Bool = false) {
        if newSearch {
            repositories.removeAll()
            DispatchQueue.main.async { [weak self] in
                self?.tableView.mySkeletonAnimation()
                self?.tableView.reloadData()
            }
        }
    
        
        viewModel.getRepositoriesBy(text: searchInputFild.text ?? "", page: "\(page)"){ [weak self] repos in
            DispatchQueue.main.async { [weak self] in
                if let repos = repos {
                    self?.repositories += repos.items?.compactMap { $0 } ?? []
                    self?.totalRepos = repos.totalCount ?? 0
                }else {
                    self?.controller.openAlert(title: "Internet Connection Error!!!", message: "", closeButtonTitle: "Try again"){ [weak self] in self?.refresh()}
                }
            }
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        RepositoryCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = skeletonView.deque(RepositoryCell.self, for: indexPath)
        return cell
    }
    func collectionSkeletonView(_ skeletonView: UITableView, prepareCellForSkeleton cell: UITableViewCell, at indexPath: IndexPath) {
        let cell = cell as? RepositoryCell
        cell?.avatarIMG.mySkeletonAnimation()
        cell?.nameLabel.mySkeletonAnimation()
        cell?.repositoryNameLabel.mySkeletonAnimation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.deque(RepositoryCell.self, for: indexPath)
        
        cell.configure(with: repositories[indexPath.row])
        
        if indexPath.row == repositories.count-1 && totalRepos > repositories.count {
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
