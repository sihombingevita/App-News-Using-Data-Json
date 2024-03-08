//
//  NewsArticle.swift
//  iOSNewsApp
//
//  Created by Evita Sihombing on 29/02/24.
//

import Foundation

struct NewsArticle: Codable {
    var results: [ArticleData]
}

struct ArticleData: Codable {
    var source: String
    var pubDate: String
    var id: Int
    var prices: [ArticleDetail]
    var title: String
    var link: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case source
        case pubDate = "pub_date"
        case id
        case prices
        case title
        case link
        case type
    }
}

struct ArticleDetail: Codable {
    let code: String
    let changePct: Double
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case code
        case changePct = "change_pct"
        case price
    }
}
