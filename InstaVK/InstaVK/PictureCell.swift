//
//  PictureCell.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 29.04.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

protocol PictureCellDelegate {
    func didTapCommentsButton(sender: PictureCell)
    func didTapLikeButton(sender: PictureCell)
}

class PictureCell: UITableViewCell {

    var post: Post?

    @IBOutlet weak var postPicture: UIImageView!
    @IBOutlet weak var postPictureHeight: NSLayoutConstraint!
    @IBOutlet weak var postUserAvatar: UIImageView!
    @IBOutlet weak var postUserFirstNameLastName: UILabel!
    @IBOutlet weak var postLikeButton: UIButton!
    
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
            delegate.didTapCommentsButton(sender: self)
        }
    }
    
    @IBAction func didTapLikeButton(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.didTapLikeButton(sender: self)
        }
    }
    
    
    override func prepareForReuse() {
        postLikeButton.setImage(#imageLiteral(resourceName: "HeartEmpty"), for: .normal)
        postPicture.image = #imageLiteral(resourceName: "error404")
        postPictureHeight.constant = 300
    }
}
