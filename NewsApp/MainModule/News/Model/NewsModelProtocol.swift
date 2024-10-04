//
//  NewsModelProtocol.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import Foundation

protocol NewsModelProtocol {
    var news: [News] { get }
    
    func updateNews(append: Bool) async throws

}
