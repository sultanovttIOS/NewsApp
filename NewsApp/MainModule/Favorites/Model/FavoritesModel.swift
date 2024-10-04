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
    private(set) var favoritesNews: [FavoritesEntity] = []
    
    // MARK: Lifecycle
    
    init() {
        self.favoritesNews = fetchFavoriteNews()
    }
    
    // MARK: Fetch
    
    func fetchFavoriteNews() -> [FavoritesEntity] {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<FavoritesEntity> = FavoritesEntity.fetchRequest()
        
        do {
            let favorites = try context.fetch(fetchRequest)
            favoritesNews = favorites
            print("Succesfully fetched fav news from coreData! \(favorites)")
            return favorites
        } catch {
            print("Failed to fetch favorites: \(error)")
            return []
        }
    }
    
    func fetchFavorites() {
        let context = persistenseController.container.viewContext
        let fetchRequest: NSFetchRequest<FavoritesEntity> = FavoritesEntity.fetchRequest()
        
        do {
            favoritesNews = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch favorites: \(error)")
        }
    }
}
