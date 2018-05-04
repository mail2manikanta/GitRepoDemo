//
//  RepoDataSource.swift
//  GitRepoDemo
//
//  Created by Manikanta Nallabelly on 5/3/18.
//  Copyright © 2018 Akvelon. All rights reserved.
//

import Foundation
import UIKit

class RepoDatasource: NSObject, UICollectionViewDataSource {
    private var repos: [Repo] = []
    private let repoService = RepoService()
    
    func loadRepos(_ searchTerm:String, _ page:Int = 1 ,completion: @escaping ()->Void) {
        repoService.loadRepos(searchTerm, page) { [weak self] (newRepos) in
            
            if let newRepos = newRepos {
                
                if page == 1 {
                    self?.repos = newRepos
                }
                else {
                    self?.repos.append(contentsOf: newRepos)
                }
                
                completion()
            }
        }
    }
    
    func repoCount() -> Int {
        return repos.count
    }
        
    func object(at indexPath: IndexPath) -> Repo {
        return repos[indexPath.item]
    }
    
    // MARK: Collectionview methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "repo", for: indexPath) as! RepoCollectionViewCell
        
        let repo = object(at: indexPath)
        cell.configure(with: repo)
        
        return cell
    }
    
}
