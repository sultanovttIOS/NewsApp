//
//  FavoritesModelProtocol.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import Foundation

protocol DetailModelProtocol {
    func addToFavorites(news: News)
    func removeFromFavorites(news: News)
    func isFavorite(news: News) -> Bool 
}
