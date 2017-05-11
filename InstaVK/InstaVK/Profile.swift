//
//  User.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 10.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import Foundation

struct Profile {
    let userId: Int
    let firstName: String
    let lastName: String
    let sex: Int
    let screenName: String
    let photo_50: String
    let photo_100: String
    let online: Int
    
    init(dictionary: [String: Any]) {
        self.userId = dictionary["uid"] as? Int ?? 0
        self.firstName = dictionary["first_name"] as? String ?? ""
        self.lastName = dictionary["last_name"] as? String ?? ""
        self.sex = dictionary["sex"] as? Int ?? 0
        self.screenName = dictionary["screen_name"] as? String ?? ""
        self.photo_50 = dictionary["photo"] as? String ?? ""
        self.photo_100 = dictionary["photo_medium_rec"] as? String ?? ""
        self.online = dictionary["online"] as? Int ?? 0
    }
}
