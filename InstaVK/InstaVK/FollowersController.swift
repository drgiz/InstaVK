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
    
    let followerCellIdentifier = "FollowerCell"
    var followers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "FollowerCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: followerCellIdentifier)
        
       
        
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
       /* let params :[String: String] = ["fields":"country"]
        let request = VKApi.friends().get(params)
        
        request?.execute(resultBlock: { (response) in
            
            let books = response?.json as! Dictionary <String, AnyObject>
            let newBooks = books["items"] as! NSArray
            for book in newBooks {
                let b = book as! Dictionary<String, AnyObject>
                let user = User()
                user.lastName = b["last_name"] as! String?
                self.followers.append(user)
            }
        }, errorBlock: { (error) in
            
        })
        */
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: followerCellIdentifier, for: indexPath) as! FollowerCell
        
        cell.followerImageView.image = #imageLiteral(resourceName: "Image")
        cell.followerImageView.layer.cornerRadius = 40
        cell.followerImageView.clipsToBounds = true
        cell.fistAndLastNameLabel.text = self.followers[indexPath.row].lastName
        
             // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
