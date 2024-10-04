//
//  FavoritesModelProtocol.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import Foundation

protocol DetailModelProtocol {
    func addToFavorites(news: NewsEntity)
    func removeFromFavorites(news: NewsEntity) 
    func isFavorite(news: NewsEntity) -> Bool 
}
