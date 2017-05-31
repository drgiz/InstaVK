//
//  FollowersController.swift
//  InstaVK
//
//  Created by Никита on 10.04.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import VK_ios_sdk
//-----------------------users.getfollowers----------------------------

class FollowersController: UITableViewController {
    
    let followerCellIdentifier = "FollowerCell"
    var followers = [User]()
    
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5//self.followers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: followerCellIdentifier, for: indexPath) as! FollowerCell
        
        cell.followerImageView.image = #imageLiteral(resourceName: "Image")
        cell.followerImageView.layer.cornerRadius = 40
        cell.followerImageView.clipsToBounds = true
        //cell.fistAndLastNameLabel.text = self.followers[indexPath.row].lastName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
