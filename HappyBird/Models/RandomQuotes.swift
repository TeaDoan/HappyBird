//
//  RandomProgmaingQuotes.swift
//  HappyBird
//
//  Created by Thao Doan on 7/12/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

class RandomQuotes: Codable{
    let author: String?
    let quote : String
    var isFavorite: Bool? = false
    
    init(author: String, quote:String, isFavorite: Bool = false) {
        self.author = author
        self.quote = quote
        self.isFavorite = isFavorite
     }
    
    }

