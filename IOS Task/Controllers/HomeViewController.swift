//
//  HomeViewController.swift
//  IOS Task
//
//  Created by Qoo on 13/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let categoriesList = ["Trending", "Technology", "Sports", "Politics", "Weather"]
    
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

extension HomeViewController : HomeViewModelDelegate {
    func onFetchNews() {
        tableView.reloadData()
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItemTableViewCell") as! NewsItemTableViewCell
        cell.configureCell(article: viewModel.newsList?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.article = viewModel.newsList?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryItemCollectionCell", for: indexPath) as! CategoryItemCollectionCell
        
        return cell
    }
    
    
}

extension HomeViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if ((searchBar.text?.isEmpty) != nil) {
            viewModel.getNews(query: searchBar.text ?? "")
            searchBar.resignFirstResponder()
        }else{
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.resignFirstResponder()
        }
    }
}
