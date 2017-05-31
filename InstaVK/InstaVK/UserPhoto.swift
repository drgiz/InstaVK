//
//  UserPhoto.swift
//  InstaVK
//
//  Created by Никита on 22.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import Foundation

struct UserPhoto {
    let photoId: Int
    let albumId: Int
    let ownerId: Int

    
    init(dictionary: [String: Any]) {
        self.photoId = dictionary["id"] as? Int ?? 0
        self.albumId = dictionary["album_d"] as? Int ?? 0
        self.ownerId = dictionary["owner_id"] as? Int ?? 0
    }
}
