//
//  APIError.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import Foundation

enum APIError: Error {
    
    case invalidServerURL
    case notHTTPResponse
    case unexpectedStatusCode
    case decodingError
    case encodingError
}
