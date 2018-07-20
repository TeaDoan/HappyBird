//
//  QuoteTableViewCell.swift
//  HappyBird
//
//  Created by Thao Doan on 7/15/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

protocol FavoriteButtonViewChangeDelegate: class  {
    func toggleIsFavorite(cell: QuoteTableViewCell)
}
class QuoteTableViewCell: UITableViewCell {
    
    var quote : RandomQuotes? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(16, 16, 16, 16))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    weak var delegate : FavoriteButtonViewChangeDelegate?

    @IBOutlet weak var favorriteButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        delegate?.toggleIsFavorite(cell: self)
        updateView()
    }
    
    
    func updateView() {
        guard  let quote = quote else {
            return
        }
        guard let isFavorite = quote.isFavorite else {return}
        if quote.isFavorite! {
            favorriteButton.setImage(#imageLiteral(resourceName: "heart-Active"), for: .normal)
        } else {
            favorriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
    }
    
    
}
