//
//  Post.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 08.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import Foundation

struct Post {
    let postId: Int
    let albumId: Int
    let ownerId: Int
    let imageUrl_75: String
    let imageUrl_130: String
    let imageUrl_604: String
    let imageUrl_807: String
    let imageUrl_1280: String
    let imageUrl_2560: String
    let imageUrl_SrcSmall: String
    let imageUrl_Src: String
    let imageUrl_SrcBig: String
    let imageUrl_SrcXBig: String
    let imageUrl_SrcXXBig: String
    let imageUrl_SrcXXXBig: String
    let imageWidth: Int
    let imageHeight: Int
    let text: String
    let date: Int
    let access_key: String
    let likes: [String:Int]
    let comments: [String:Int]
    let can_comment: Int
    let can_repost: Int
    var userLikes: Int
    
    //Note: SRC_SIZE photo urls come in FIRST JSON response, next - PHOTO_SIZE urls)
    init(dictionary: [String: Any]) {
        self.postId = dictionary["pid"] as? Int ?? 0
        self.albumId = dictionary["aid"] as? Int ?? 0
        self.ownerId = dictionary["owner_id"] as? Int ?? 0
        self.imageUrl_75 = dictionary["photo_75"] as? String ?? ""
        self.imageUrl_130 = dictionary["photo_130"] as? String ?? ""
        self.imageUrl_604 = dictionary["photo_804"] as? String ?? ""
        self.imageUrl_807 = dictionary["photo_807"] as? String ?? ""
        self.imageUrl_1280 = dictionary["photo_1280"] as? String ?? ""
        self.imageUrl_2560 = dictionary["photo_2560"] as? String ?? ""
        self.imageUrl_SrcSmall = dictionary["src_small"] as? String ?? ""
        self.imageUrl_Src = dictionary["src"] as? String ?? ""
        self.imageUrl_SrcBig = dictionary["src_big"] as? String ?? ""
        self.imageUrl_SrcXBig = dictionary["src_xbig"] as? String ?? ""
        self.imageUrl_SrcXXBig = dictionary["src_xxbig"] as? String ?? ""
        self.imageUrl_SrcXXXBig = dictionary["src_xxxbig"] as? String ?? ""
        self.imageWidth = dictionary["width"] as? Int ?? 0
        self.imageHeight = dictionary["height"] as? Int ?? 0
        self.text = dictionary["text"] as? String ?? ""
        self.date = dictionary["date"] as? Int ?? 0
        self.access_key = dictionary["access_key"] as? String ?? ""
        self.likes = dictionary["likes"] as? [String:Int] ?? [String:Int]()
        self.userLikes = self.likes["user_likes"] ?? 0
        self.comments = dictionary["comments"] as? [String:Int] ?? [String:Int]()
        self.can_comment = dictionary["can_comment"] as? Int ?? 0
        self.can_repost = dictionary["can_repost"] as? Int ?? 0
    }
}
