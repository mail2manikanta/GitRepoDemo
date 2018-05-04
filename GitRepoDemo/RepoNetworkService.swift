//
//  RepoNetworkService.swift
//  GitRepoDemo
//
//  Created by Manikanta Nallabelly on 5/3/18.
//  Copyright © 2018 Akvelon. All rights reserved.
//

import Foundation

public class RepoService {
    
    func urlForReposMatching( _ searchTerm:String, _ page:Int) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = kHostURL
        
        let path = kPath1 + searchTerm + kPath2
        urlComponents.path = path
        
        var queryItems = [URLQueryItem]()
        
        let pageQueryItem = URLQueryItem(name: "page", value: String(page))
        let pageSizeQueryItem = URLQueryItem(name: "per_page", value: String(kPageSize))
        queryItems.append(contentsOf: [pageQueryItem, pageSizeQueryItem])
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    func loadRepos(_ searchTerm:String, _ page:Int, _  completion: @escaping ([Repo]?)->Void) -> Void  {
        
        guard let repoURL = urlForReposMatching(searchTerm, page) else {

            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        URLSession.shared.dataTask(with: repoURL) { (data, response, error) in
            
            do {
                if let data = data {
                    let repos = try JSONDecoder().decode([Repo].self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(repos)
                    }
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil)
                }            }
            
            }.resume()
    }
}
