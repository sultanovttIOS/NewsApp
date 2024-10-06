//
//  FavoritesModel.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import Foundation
import CoreData

final class FavoritesModel: FavoritesModelProtocol {
    
    // MARK: Properties
    
    private var persistenseController = PersistenceController.shared
    private(set) var favoritesNews: [News] = []
    
    // MARK: Lifecycle
    
    init() {
        fetchFavorites()
    }
    
    // MARK: Fetch
    
    func fetchFavorites() {
        let context = persistenseController.container.viewContext
        let fetchRequest: NSFetchRequest<FavoritesEntity> = FavoritesEntity.fetchRequest()
        
        do {
            let favoritesEntities = try context.fetch(fetchRequest)
            favoritesNews = favoritesEntities.map { favorite in
                News(
                    articleId: favorite.articleID ?? "",
                    title: favorite.title ?? "",
                    link: favorite.link ?? "",
                    description: favorite.desc ?? "",
                    pubDate: favorite.pubDate ?? "",
                    imageUrl: favorite.imageUrl ?? "",
                    sourceName: favorite.sourceName ?? ""
                )
            }
        } catch {
            print("Failed to fetch favorites: \(error)")
        }
    }
}
