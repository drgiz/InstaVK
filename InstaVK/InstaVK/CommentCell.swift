//
//  CommentCell.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 02.04.17.
//  Copyright © 2017 Svyatoslav Bykov. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var userFirstLastName: UIButton!

    //var comment:
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
