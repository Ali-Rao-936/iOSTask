//
//  HomeVc + Extensions.swift
//  IOS Task
//
//  Created by Kami on 16/10/2023.
//

import Foundation
import UIKit

extension HomeViewController : HomeViewModelDelegate {
    func onFetchNews() {
        tableView.reloadData()
        tableView.scrollToTop()
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
        cell.nameLable.text = categoriesList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // network call
        viewModel.getNews(query: categoriesList[indexPath.row])
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
