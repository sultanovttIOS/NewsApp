//
//  NetworkServiceProtocol.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import UIKit

protocol NetworkServiceProtocol: Actor {
    
    func getNews(nextPage: String?) async throws -> NewsResponse
    func getImage(from url: URL) async -> UIImage?

}
