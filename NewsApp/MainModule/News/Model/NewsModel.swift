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
    private var currentNextPage: String?

    // MARK: Lifecycle

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func updateNews(append: Bool) async throws {
        
        if append && news.count >= countOfAllNews { return }
        
        let newsResponse: NewsResponse
        
        if append {
            guard let nextPage = currentNextPage else { return }
            newsResponse = try await networkService.getNews(nextPage: nextPage)
        } else {
            newsResponse = try await networkService.getNews(nextPage: nil)
            countOfAllNews = newsResponse.totalResults
        }

        news.append(contentsOf: newsResponse.results)
        currentNextPage = newsResponse.nextPage
    }
}
