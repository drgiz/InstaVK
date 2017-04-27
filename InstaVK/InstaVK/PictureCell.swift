//
//  PictureCell.swift
//  InstaVK
//
//  Created by Никита on 29.03.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

protocol PictureCellDelegate {
    func didTapButton(sender: UITableViewCell)
}

class PictureCell: UITableViewCell {

    @IBOutlet weak var postPicture: UIImageView!
    @IBOutlet weak var postUserAvatar: UIImageView!
    @IBOutlet weak var postUserFirstNameLastName: UILabel!
    
//    #TO-DO
//    Figure out why you should make outlet to PostPicture, but not to File's owner (causes crash at NewsScreen)
    
    var delegate: PictureCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapCommentsButton(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.didTapButton(sender: self)
        }
    }
}
