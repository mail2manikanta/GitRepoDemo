//
//  RepoViewController.swift
//  GitRepoDemo
//
//  Created by Manikanta Nallabelly on 5/3/18.
//  Copyright © 2018 Akvelon. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)

    var presenter: RepoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionView.setCollectionViewLayout( ListFlowLayout(), animated: true)
        
        // Initially loading "apple" repos (dont want to show blank screen for usability)
        presenter.loadRepos("apple")
    }

    func reloadData() {
        collectionView.reloadData()
    }
    
    func setup() {
        
        presenter = RepoPresenter(viewController: self)
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = presenter
       // searchController.delegate = presenter
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.placeholder = "Search Repos"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        collectionView.dataSource = presenter.datasource
        collectionView.delegate = presenter
    }
    
    @IBAction func indexChanged(_ sender: AnyObject) {
        let segmentedControl = sender as! UISegmentedControl
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            UIView.animate(withDuration: kAnimationDuration) { () -> Void in
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(ListFlowLayout(), animated: true)
            }
        case 1:
            UIView.animate(withDuration: kAnimationDuration) { () -> Void in
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(GridFlowLayout(), animated: true)
            }
        default:
            break
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

