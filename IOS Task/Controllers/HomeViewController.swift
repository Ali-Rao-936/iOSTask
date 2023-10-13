//
//  HomeViewController.swift
//  IOS Task
//
//  Created by Qoo on 13/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.getNews(query: "tesla")
    }
    

}

extension HomeViewController : HomeViewModelDelegate {
    func onFetchNews() {
        print(viewModel.newsList?[0].title ?? "")
    }

}
