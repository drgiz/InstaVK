//
//  Comment.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 23.05.17.
//  Copyright © 2017 InstaVK. All rights reserved.
//

import Foundation

struct Comment {
    let commentId: Int
    let ownerId: Int
    let date: Int
    let text: String
    let likes: [String:Int]
    
    init(dictionary: [String: Any]){
        self.commentId = dictionary["id"] as? Int ?? 0
        self.ownerId = dictionary["from_id"] as? Int ?? 0
        self.date = dictionary["date"] as? Int ?? 0
        self.text = dictionary["text"] as? String ?? ""
        self.likes = dictionary["likes"] as? [String:Int] ?? [String:Int]()    }
}
