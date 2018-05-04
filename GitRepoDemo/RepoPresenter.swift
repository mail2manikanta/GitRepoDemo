//
//  RepoPresenter.swift
//  GitRepoDemo
//
//  Created by Manikanta Nallabelly on 5/3/18.
//  Copyright © 2018 Akvelon. All rights reserved.
//

import Foundation
import UIKit

class RepoPresenter: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var viewController: RepoViewController?
    let datasource: RepoDatasource = RepoDatasource()
    var searchQuery:String = "apple"
    private var currentPage = 1

    init(viewController: RepoViewController?) {
        super.init()
        self.viewController = viewController
    }
    
    func loadRepos(_ searchTerm:String, _ page:Int = 1 ) {
        currentPage = page
        searchQuery = searchTerm
        datasource.loadRepos(searchTerm, page) { [weak self] in
            self?.viewController?.reloadData()
        }
    }
    
    // MARK: Collectionview
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle the cell selection here
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kGridItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == datasource.repoCount() - 1  {
            currentPage = datasource.repoCount()/kPageSize
            loadRepos(searchQuery, currentPage + 1)
        }
    }
}

extension RepoPresenter: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        if let searchText = searchBar.text, !(searchText.isEmpty) {
            loadRepos(searchText)
        }
    }
}

