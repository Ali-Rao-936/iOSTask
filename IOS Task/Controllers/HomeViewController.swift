//
//  HomeViewController.swift
//  IOS Task
//
//  Created by Ali on 13/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let categoriesList = ["Trending", "Sports", "Politics", "Weather", "Technology"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    // variables
    var viewModel = HomeViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar(name: "NewsStand")
        
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        
        // network call
        viewModel.getNews(query: "tesla")
        
        // tableview setup
        tableView.registerCell(identifier: "NewsItemTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // collection view setup
        collectionView.registerCell(identifier: "CategoryItemCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // search
        searchBar.delegate = self
        
    }
    

}


