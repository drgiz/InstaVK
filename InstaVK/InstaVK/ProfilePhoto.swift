//
//  ProfilePhoto.swift
//  InstaVK
//
//  Created by Никита on 26.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

struct ProfilePhoto {
    
    let id: Int
    let albumId: Int
    let ownerId: Int
    let imageUrl_75: String
    let imageUrl_130: String
    let imageUrl_604: String
    let imageUrl_807: String
    let imageUrl_1280: String
    let imageUrl_2560: String
    let imageWidth: Int
    let imageHeight: Int
    let text: String
    let date: Int

    init(dictionary:[String: Any]) {
        self.id = dictionary["pid"] as? Int ?? 0
        self.albumId = dictionary["aid"] as? Int ?? 0
        self.ownerId = dictionary["owner_id"] as? Int ?? 0
        self.imageUrl_75 = dictionary["src_small"] as? String ?? ""
        self.imageUrl_130 = dictionary["src"] as? String ?? ""
        self.imageUrl_604 = dictionary["src_big"] as? String ?? ""
        self.imageUrl_807 = dictionary["src_xbig"] as? String ?? ""
        self.imageUrl_1280 = dictionary["src_xxbig"] as? String ?? ""
        self.imageUrl_2560 = dictionary["src_xxxbig"] as? String ?? ""
        self.imageWidth = dictionary["width"] as? Int ?? 0
        self.imageHeight = dictionary["height"] as? Int ?? 0
        self.text = dictionary["text"] as? String ?? ""
        self.date = dictionary["date"] as? Int ?? 0
    }

}
