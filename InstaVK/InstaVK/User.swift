//
//  User.swift
//  InstaVK
//
//  Created by Никита on 20.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

struct User {
    
    let firstName: String
    let lastName: String
    let photoMediumURL: String
    let userId: Int
    
    
    init(dictionary: [String: Any]) {
        
        self.firstName = dictionary["first_name"] as? String ?? ""
        self.lastName = dictionary["last_name"] as? String ?? ""
        self.photoMediumURL = dictionary["photo_medium"] as? String ?? ""
        self.userId = dictionary["uid"] as? Int ?? 0
    }
}
