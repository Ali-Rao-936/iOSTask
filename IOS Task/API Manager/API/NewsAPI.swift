//
//  NewsAPI.swift
//  IOS Task
//
//  Created by ALi on 13/10/2023.
//

import Foundation


class NewssAPI : WebService {
    
    func getAllNews(param:[String:Any], completion:@escaping (NewsResponse?) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl(apiType: .NEWS) + EndPoints.everything.rawValue
        get(url: url, params: param, completion: { json in
            let response = NewsResponse(json!)
            completion(response)
        }, failed: failed)
    }
    
    
}
