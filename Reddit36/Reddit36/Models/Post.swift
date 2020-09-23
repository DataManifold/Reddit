//
//  Post.swift
//  Reddit36
//
//  Created by Shean Bjoralt on 9/23/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let data: SecondLevelDictionary
}

struct SecondLevelDictionary: Decodable {
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject: Decodable {
    let data: Post
}

struct Post: Decodable {
    let title: String
    let ups: Int
    let thumbnail: URL?
}
