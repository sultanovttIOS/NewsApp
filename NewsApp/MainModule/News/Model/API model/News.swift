//
//  API models.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import Foundation

struct NewsResponse: Decodable {
    let totalResults: Int
    let results: [News]
    let nextPage: String
}

struct News: Decodable {
    
    let articleId: String
//    let title: String
//    let link: String
//    let creator: [String]
    let description: String
    let pubDate: String
    let imageUrl: String
    let sourceName: String
//    let sourceIcon: String
}

