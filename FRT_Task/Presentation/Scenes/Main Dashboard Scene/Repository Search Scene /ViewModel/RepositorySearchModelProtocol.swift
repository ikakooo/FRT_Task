//
//  RepositorySearchModelProtocol.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 30.03.22.
//

import Foundation

protocol RepositorySearchModelProtocol:AnyObject {
    func getRepositoriesBy(text: String, completion: @escaping ((RepositoryModel) -> Void))
}

final class RepositorySearchModel: RepositorySearchModelProtocol {
    // DI
    private var networkManager: NetworkManagerProtocol!
    private var repositoryNetworkManager: RepositoryNetworkManager!
    
    init(){
        // DI - Dependenc injection
        networkManager = NetworkManager()
        repositoryNetworkManager = RepositoryNetworkManager(networkManager: networkManager)
    }
    
    func getRepositoriesBy(text: String, completion: @escaping ((RepositoryModel) -> Void)){
        repositoryNetworkManager.searchRepositories(with: text){ repos in
            completion(repos)
        }
        
    }
    
    
}
