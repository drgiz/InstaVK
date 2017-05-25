//
//  UserPhoto.swift
//  InstaVK
//
//  Created by Никита on 22.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import Foundation

struct UserPhoto {
    let userPhotoId: Int
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
    let access_key: String
    let likes: [String:Int]
    let comments: [String:Int]
    let can_comment: Int
    let can_repost: Int
}
