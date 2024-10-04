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

    private let imageCache = NSCache<NSString, CacheImageObject>()

    // MARK: Get news
    
    func getNews(nextPage: String?) async throws -> NewsResponse {
        guard var url = URL(string: baseURL) else {
            logger.error("Invalid server URL: \(self.baseURL)")
            throw APIError.invalidServerURL
        }
        
        if let nextPage = nextPage {
            url.append(queryItems: [URLQueryItem(name: "page", value: nextPage)])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
 
        logger.info("Starting request: \(url.absoluteString)")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            logger.error("API response is not HTTP response")
            throw APIError.notHTTPResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            var message = "Unexpected status code: \(httpResponse.statusCode)"
            if let serverMessage = String(data: data, encoding: .utf8) {
                message += "\n\(serverMessage)"
            }
            logger.error("\(message)")
            throw APIError.unexpectedStatusCode
        }
        
        let newsResponse: NewsResponse
        do {
            newsResponse = try decoder.decode(NewsResponse.self, from: data)
            logger.info("Received tours for request: \(url.absoluteString)")
        } catch {
            logger.error("Could not decode data for request: \(url.absoluteString)\n\(error)")
            throw APIError.decodingError
        }
        
        return newsResponse
    }
    
    // MARK: Image Cache
    
    func getImage(from url: URL) async -> UIImage? {
        if let cached = imageCache[url] {
            switch cached {
            case .inProgress(let task):
                return try? await task.value
            case .ready(let image):
                logger.info("Got image from the cache for url: \(url.absoluteString)")
                return image
            }
        }
        
        let task = Task<UIImage?, Error> {
            logger.info("Starting request: \(url.absoluteString)")
            let (data, _) = try await session.data(from: url)
            let image = UIImage(data: data)
            return image
        }
        imageCache[url] = .inProgress(task)
        let image = try? await task.value
        if let image {
            imageCache[url] = .ready(image)
        }
        return image
    }
}
