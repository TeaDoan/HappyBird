//
//  SearchJokes.swift
//  HappyBird
//
//  Created by Thao Doan on 7/18/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

struct SearchJoke: Codable {
    var joke : String
}

struct Results: Codable{
    var results : [SearchJoke]
}
