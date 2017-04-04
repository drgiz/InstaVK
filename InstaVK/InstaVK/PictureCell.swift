//
//  PictureCell.swift
//  InstaVK
//
//  Created by Никита on 29.03.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

class PictureCell: UITableViewCell {

    @IBOutlet weak var postPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
