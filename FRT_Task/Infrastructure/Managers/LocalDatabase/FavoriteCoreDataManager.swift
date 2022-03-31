//
//  FavoriteCoreDataManager.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 31.03.22.
//

import UIKit
import CoreData

class FavoriteCoreDataManager {
    static let shared = FavoriteCoreDataManager()
    private init(){}
    
    
    func saveFavorite(info:Item){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new UserEntity in the
        // NSManagedObjectContext context
        let repo = Favorite(context: managedContext)
        
        // Assign values to the entity's properties
        repo.id = "\(info.id ?? 0)"
        repo.nodeID = info.nodeID
        repo.owner = info.owner?.login
        repo.repo = info.name
        repo.fullName = info.fullName
        repo.language = info.language
        repo.itemDescription = info.itemDescription
        repo.htmlURL = info.htmlURL
        repo.createdAt = info.createdAt
        repo.avatarURL = info.owner?.avatarURL
    
        
        
        // To save the new entity to the persistent store, call
        // save on the context
        do {
            try managedContext.save()
        }
        catch {
            // Handle Error
        }
    }
    
    
    func tryFetchAllFavorites()->[Item]{
        var allFavorites:[Item] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return allFavorites
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        print("Fetching Data..")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: "id") as? Int
                let nodeID = data.value(forKey: "nodeID") as? String
                let repo = data.value(forKey: "repo") as? String
                let fullName = data.value(forKey: "fullName") as? String
                let ownerName = data.value(forKey: "owner") as? String
                let htmlURL = data.value(forKey: "htmlURL") as? String
                let itemDescription = data.value(forKey: "itemDescription") as? String
                let createdAt = data.value(forKey: "createdAt") as? String
                let language = data.value(forKey: "language") as? String
                let avatarURL = data.value(forKey: "avatarURL") as? String
                let owner = Owner(login: ownerName, id: nil, nodeID: nil, avatarURL: avatarURL, gravatarID: nil, url: nil, htmlURL: nil, followersURL: nil, followingURL: nil, gistsURL: nil, starredURL: nil, subscriptionsURL: nil, organizationsURL: nil, reposURL: nil, eventsURL: nil, receivedEventsURL: nil, type: nil, siteAdmin: nil)

                allFavorites.append(Item(id: id, nodeID: nodeID, name: repo, fullName: fullName, itemPrivate: nil, owner: owner, htmlURL: htmlURL, itemDescription: itemDescription, fork: nil, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL: nil, stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil, createdAt: createdAt, gitURL: nil, sshURL: nil, cloneURL: nil, svnURL: nil, homepage: nil, size: nil, stargazersCount: nil, watchersCount: nil, language: language, hasIssues: nil, hasProjects: nil, hasDownloads: nil, hasWiki: nil, hasPages: nil, forksCount: nil, archived: nil, disabled: nil, openIssuesCount: nil, allowForking: nil, isTemplate: nil, topics: nil, visibility: nil, forks: nil, openIssues: nil, watchers: nil, defaultBranch: nil, score: nil))
            }
        } catch {
            print("Fetching data Failed")
        }
        return allFavorites
    }
    
    
    func deleteFavorite(repo:Item) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        print("Fetching Data..")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            for data in result as! [NSManagedObject] {
                let fullName = data.value(forKey: "fullName") as? String
               
                
                if fullName == repo.fullName {
                    managedContext.delete(data)
                    try managedContext.save()
                }
            }
        } catch {
            print("Fetching data Failed")
        }
    }
    
}
