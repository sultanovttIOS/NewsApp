//
//  NetworkService.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import UIKit
import OSLog

actor NetworkService: NetworkServiceProtocol {
    
    // MARK: Properties

    static let shared: NetworkServiceProtocol = NetworkService()
        
    private let session: URLSession = {
        let session = URLSession(configuration: .default)
        session.configuration.timeoutIntervalForRequest = 15
        return session
    }()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "",
        category: String(describing: NetworkService.self)
    )
    
    private let baseURL = "https://newsdata.io/api/1/news?apikey=pub_55238d2c462decee315a235f19ef3268c3b02&q=food&category=food"
    
    // MARK: Get news
    
    
}
