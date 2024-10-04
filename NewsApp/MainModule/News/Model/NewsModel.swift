//
//  NewsModel.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import Foundation
import CoreData
import UIKit

final class NewsModel: NewsModelProtocol {
    
    // MARK: Properties

    private let networkService: NetworkServiceProtocol
    private(set) var countOfAllNews = 0
    private var currentNextPage: String?
    private var persistenceController = PersistenceController.shared
    private(set) var newsFromLocal: [NewsEntity] = []
    
    // MARK: Lifecycle

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.newsFromLocal = fetchSavedNews()
    }
    
    func updateNews(append: Bool) async throws {
        
        if append && newsFromLocal.count >= countOfAllNews { return }
        
        let newsResponse: NewsResponse
        
        if append {
            guard let nextPage = currentNextPage else { return }
            newsResponse = try await networkService.getNews(nextPage: nextPage)
        } else {
            newsResponse = try await networkService.getNews(nextPage: nil)
            countOfAllNews = newsResponse.totalResults
        }

        let context = persistenceController.container.viewContext
        saveNews(newsResponse.results, context: context)
        
        newsFromLocal = fetchSavedNews()
        currentNextPage = newsResponse.nextPage
    }
    
    func saveNews(_ news: [News], context: NSManagedObjectContext) {
        for newsItem in news {
            let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "articleID == %@", newsItem.articleId)

            let count = (try? context.count(for: fetchRequest)) ?? 0
            if count == 0 {
                let entity = NewsEntity(context: context)
                entity.articleID = newsItem.articleId
                entity.title = newsItem.title
                entity.link = newsItem.link
                entity.desc = newsItem.description
                entity.pubDate = newsItem.pubDate
                entity.imageUrl = newsItem.imageUrl
                entity.sourceName = newsItem.sourceName
            }
        }

        do {
            try context.save()
            print("Succesfully saved in CoreData \(news)")
        } catch {
            print("Failed to save news: \(error)")
        }
    }

    
    func fetchSavedNews() -> [NewsEntity] {
        let context = persistenceController.container.viewContext
        let request: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        
        do {
            let savedNews = try context.fetch(request)
            print("Succesfully fetched news from Core Data")
            return savedNews
        } catch {
            print("Failed to fetch saved news: \(error)")
            return []
        }
    }
}
