//
//  Friend.swift
//  InstaVK
//
//  Created by Никита on 31.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

struct Friend {
    
    let firstName: String
    let lastName: String
    let photo50URL: String
    let userId: Int
    
    
    init(dictionary: [String: Any]) {
        
        self.firstName = dictionary["first_name"] as? String ?? ""
        self.lastName = dictionary["last_name"] as? String ?? ""
        self.photo50URL = dictionary["photo_50"] as? String ?? ""
        self.userId = dictionary["id"] as? Int ?? 0
    }

}
