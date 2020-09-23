//
//  PostController.swift
//  Reddit36
//
//  Created by Shean Bjoralt on 9/23/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import UIKit

// Final URL: https://www.reddit.com/r/funny/.json

struct StringConstants {
    fileprivate static let baseURL = "https://www.reddit.com"
    fileprivate static let rEndpoint = "r"
    fileprivate static let funnyEndpoint = "funny"
    fileprivate static let jsonExtention = "json"
}

class PostController {
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURL) else { return completion(.failure(.invalidURL))}
        let rComponentURL = baseURL.appendingPathComponent(StringConstants.rEndpoint)
        let funnyComponent = rComponentURL.appendingPathComponent(StringConstants.funnyEndpoint)
        let finalURL = funnyComponent.appendingPathExtension(StringConstants.jsonExtention)
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let secondLevelDictionary = topLevelDictionary.data
                let thirdLevelObjects = secondLevelDictionary.children
                
                var postsPlaceholderArray: [Post] = []
                
                for object in thirdLevelObjects {
                    let post = object.data
                    postsPlaceholderArray.append(post)
                }
                completion(.success(postsPlaceholderArray))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchThumbnailFor(post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        
        guard let url = post.thumbnail else { return completion(.failure(.invalidURL)) }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thownImageError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            guard let thumbnnailImage = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            completion(.success(thumbnnailImage))
        }.resume()
    }
}
