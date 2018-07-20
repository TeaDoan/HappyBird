//
//  RandomQuoteController.swift
//  HappyBird
//
//  Created by Thao Doan on 7/20/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

class RandomQuoteController: FavoriteButtonViewChangeDelegate {
    
    static let shared = RandomQuoteController()
    
    func toggleIsFavorite(cell: QuoteTableViewCell){
    guard var quote = cell.quote else {print("There was no Quote in the Cell") ; return }
        if quote.isFavorite != nil {
            quote.isFavorite! = !quote.isFavorite!
        } else {
            quote.isFavorite = true
        }
    
    }
}
