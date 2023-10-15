//
//  NewsResponse.swift
//  IOS Task
//
//  Created by Ali on 13/10/2023.
//

import Foundation
import SwiftyJSON

struct NewsResponse {

    let status: String?
    let totalResults: Int?
    let articles: [Articles]?

    init(_ json: JSON) {
        status = json["status"].stringValue
        totalResults = json["totalResults"].intValue
        articles = json["articles"].arrayValue.map { Articles($0) }
    }

}

struct Articles {

    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    init(_ json: JSON) {
        source = Source(json["source"])
        author = json["author"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        url = json["url"].stringValue
        urlToImage = json["urlToImage"].stringValue
        publishedAt = json["publishedAt"].stringValue
        content = json["content"].stringValue
    }

}


struct Source {

    let id: Any?
    let name: String?

    init(_ json: JSON) {
        id = json["id"]
        name = json["name"].stringValue
    }

}
