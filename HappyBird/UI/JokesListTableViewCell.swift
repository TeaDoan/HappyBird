//
//  JokesListTableViewCell.swift
//  HappyBird
//
//  Created by Thao Doan on 7/14/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class JokesListTableViewCell: UITableViewCell {
    
    var joke : Value?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var jokeLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
