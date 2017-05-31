//
//  FollowersController.swift
//  InstaVK
//
//  Created by Никита on 10.04.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import VK_ios_sdk


class FollowersController: UITableViewController {
    
    var countFriends  = Int()
    
    let followerCellIdentifier = "FollowerCell"
    var followers = [User]()
    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "FollowerCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: followerCellIdentifier)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    convenience init(id : String) {
        self.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFriends()
    }
    
    func fetchFriends(){
        
      let request = VKApi.friends().get(["order":"name",
                                         "fields":"photo_50",
                                         "name_case":"nom"])
        
        request?.execute(resultBlock: { (response) in
            
            let dictResponse = response?.json as? [String : Any]
            print(response?.json)
            
            let itemsDict = dictResponse?["items"] as? [Any]
            
            for item in itemsDict! {
                if let itemDict = item as? [String : Any] {
                
                    let friend  = Friend(dictionary: itemDict)
                    self.friends.append(friend)
                }
            }
            
            
            
             self.countFriends = dictResponse?["count"] as? Int ?? 0
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, errorBlock: { (error) in
            
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count//self.followers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: followerCellIdentifier, for: indexPath) as! FollowerCell
        
        let friend = self.friends[indexPath.row]
        
        cell.followerImageView.sd_setImage(with: URL(string: friend.photo50URL))
        cell.followerImageView.layer.cornerRadius = 40
        cell.followerImageView.clipsToBounds = true
        cell.fistAndLastNameLabel.text = friend.firstName + " " + friend.lastName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
