//
//  NetworkManager.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 08.05.17.
//  Copyright © 2017 InstaVK. All rights reserved.
//
import UIKit
import VK_ios_sdk

func vkApiUrlBuilder(vkApiMethod: String, queryItems: [String:String]...) -> URL? {
    let components = NSURLComponents()
    components.scheme = "https"
    components.host = "api.vk.com"
    components.path = "/method/"+vkApiMethod
    var items = [URLQueryItem]()
    for item in queryItems {
        for (name, value) in item {
            items.append(URLQueryItem(name: name, value: value))
        }
    }
    components.queryItems = items
    if let url = components.url {
        return url
    } else {
        return nil
    }
}

//TEST
func getUsers() {
    let request: VKRequest = VKApi.friends().get(["order":"name", "count":3, "fields":"domain, photo_100" ])
    request.execute(resultBlock: { (response) -> Void in
        guard let dictionaries = response?.json as? [String:Any] else { return }
        dictionaries.forEach({ (key, value) in
            guard let dictionary = value as? [String: Any] else { return }
            print(dictionary)
        })
    },errorBlock: {(_ error: Error?) -> Void in
        print("Error: \(error.debugDescription)")
    })
}

