//
//  CacheImageObject.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import UIKit

final class CacheImageObject {
    
    let cacheImage: CacheImage
    
    init(cacheImage: CacheImage) {
        self.cacheImage = cacheImage
    }
    
}

enum CacheImage {
    
    case inProgress(Task<UIImage?, Error>)
    case ready(UIImage)
    
}

extension NSCache where KeyType == NSString, ObjectType == CacheImageObject {
    
    subscript(_ url: URL) -> CacheImage? {
        get  {
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.cacheImage
        }
        set {
            let key = url.absoluteString as NSString
            if let cacheImage = newValue {
                let value = CacheImageObject(cacheImage: cacheImage)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
    
}
