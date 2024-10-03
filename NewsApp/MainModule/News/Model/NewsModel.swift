//
//  NewsModel.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import Foundation

final class NewsModel: NewsModelProtocol {
    
    // MARK: Properties

    private let networkService: NetworkServiceProtocol
    private(set) var news: [News] = []
    private(set) var countOfAllNews = 0
    
    // MARK: Lifecycle

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
