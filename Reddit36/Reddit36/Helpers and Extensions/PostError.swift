//
//  PostError.swift
//  Reddit36
//
//  Created by Shean Bjoralt on 9/23/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import Foundation

enum PostError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case thownImageError(Error)
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server failed to reach the URL."
        case .thrownError(let error):
            return "There was an error: \(error.localizedDescription)."
        case .noData:
            return "No data found."
        case .thownImageError(let error):
            return "Could not display image: \(error.localizedDescription)."
        case .unableToDecode:
            return " There was an error decoding data."
        }
    }
    
}
