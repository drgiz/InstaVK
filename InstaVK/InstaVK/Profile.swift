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
    let photoUrl: String
    let photoUrl_medium_rec: String
    let photoUrl_50: String
    let photoUrl_100: String
    let online: Int
    
    init(dictionary: [String: Any]) {
        self.userId = dictionary["uid"] as? Int ?? 0
        self.firstName = dictionary["first_name"] as? String ?? ""
        self.lastName = dictionary["last_name"] as? String ?? ""
        self.sex = dictionary["sex"] as? Int ?? 0
        self.screenName = dictionary["screen_name"] as? String ?? ""
        self.photoUrl = dictionary["photo"] as? String ?? ""
        self.photoUrl_medium_rec = dictionary["photo_medium_rec"] as? String ?? ""
        self.photoUrl_50 = dictionary["photo_50"] as? String ?? ""
        self.photoUrl_100 = dictionary["photo_100"] as? String ?? ""
        self.online = dictionary["online"] as? Int ?? 0
    }
}
