//
//  HomeViewModel.swift
//  IOS Task
//
//  Created by Qoo on 13/10/2023.
//

import Foundation

class HomeViewModel {
    
    var delegate : HomeViewModelDelegate?
    var newsList : [Articles]?
    
    func getNews(query : String){
        Utility.showProgress()
        let param = [ "q" : query, "from" : "2023-10-12", "sortBy" : "publishedAt", "apiKey" : Constants.ApiKey]
        
        NewssAPI().getAllNews(param: param, completion: { response in
            
            self.newsList = response?.articles
            self.delegate?.onFetchNews()
            Utility.dismissProgress()
            
        }, failed: { error in
            Utility.showErrorSnackView(message: error)
            Utility.dismissProgress()
        })
    }
    
}

protocol HomeViewModelDelegate {
    
    func onFetchNews()
}
