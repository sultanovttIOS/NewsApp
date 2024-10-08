//
//  FavoritesModel.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import Foundation
import CoreData

final class DetailModel: DetailModelProtocol {
    
    private var persistenceController = PersistenceController.shared
    
    func addToFavorites(news: News) {
        let context = persistenceController.container.viewContext
        
        let favorite = FavoritesEntity(context: context)
        favorite.articleID = news.articleId
        favorite.title = news.title
        favorite.sourceName = news.sourceName
        favorite.desc = news.description
        favorite.imageUrl = news.imageUrl
        favorite.link = news.link
        favorite.pubDate = news.pubDate
        
        do {
            try context.save()
            print("\(String(describing: news.sourceName)) added to favorites")
        } catch {
            print("Failed to save favorite: \(error)")
        }
    }

    func removeFromFavorites(news: News) {
        let context = persistenceController.container.viewContext
        let fetchRequest: NSFetchRequest<FavoritesEntity> = FavoritesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "articleID == %@", news.articleId)

        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object)
            }
            try context.save()
            print("\(String(describing: news.sourceName)) removed from favorites")
        } catch {
            print("Failed to remove favorite: \(error)")
        }
    }
    
    func isFavorite(news: News) -> Bool {
        let context = persistenceController.container.viewContext
        let fetchRequest: NSFetchRequest<FavoritesEntity> = FavoritesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "articleID == %@", news.articleId)

        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Failed to check if news is favorite: \(error)")
            return false
        }
    }
}
