//
//  RepositoryNetworkManager.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 31.03.22.
//

import Foundation


class RepositoryNetworkManager {
    
    private var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func searchRepositories(with text:String,page:String, completion: @escaping ((RepositoryModel?) -> Void)) {
        let queries = ["q": text,
                       "page": page,
                       "per_page":"1000"]
        
        networkManager.get(url: RepositoryConstants.BASE_URL_Repository, path: RepositoryConstants.Repository_URL_PATH , queryParams: queries) { (result: Result<RepositoryModel, Error>) in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse)
            case .failure(let error):
                print("\(error) ikakooooooooo")
                completion(nil)
            }
        }
    }
}
