//
//  FollowerCell.swift
//  InstaVK
//
//  Created by Никита on 10.04.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

class FollowerCell: UITableViewCell {
    
    @IBOutlet weak var followerImageView: UIImageView!

    @IBOutlet weak var fistAndLastNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
