//
//  FavoritesModelProtocol.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import Foundation

protocol FavoritesModelProtocol {
    var favoritesNews: [FavoritesEntity] { get }
    func fetchFavoriteNews() -> [FavoritesEntity]
    func fetchFavorites() 
}
