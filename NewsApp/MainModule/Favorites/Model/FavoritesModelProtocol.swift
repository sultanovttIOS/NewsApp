//
//  FavoritesModelProtocol.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import Foundation

protocol FavoritesModelProtocol {
    var favoritesNews: [News] { get }
    func fetchFavorites() 
}
