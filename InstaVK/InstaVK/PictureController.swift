//
//  PictureController.swift
//  InstaVK
//
//  Created by Никита on 12.04.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import VK_ios_sdk

//removed PictureCellDelegate protocol reference until DelegateFix

class PictureController: UITableViewController, PictureCellDelegate {
    
    var mainImage = UIImageView()
    var mainImageURL = String()
    var post : Post?
    
    
    let pictureCellIdentifier = "pictureCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let nib = UINib.init(nibName: "PictureCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: pictureCellIdentifier)
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pictureCellIdentifier, for: indexPath) as! PictureCell
        
        cell.delegate = self
        let scale: CGFloat = CGFloat(self.post!.imageWidth)/UIScreen.main.bounds.width
        cell.postPictureHeight.constant = CGFloat((self.post?.imageHeight)!)/scale
        //TO-DO: Fix it based on post model change due to image url in JSON
        cell.postPicture.sd_setImage(with: URL(string: (self.post?.imageUrl_807)!))
        //cell.postUserAvatar.sd_setImage(with: URL(string: (self.post?.imageUrl_130)!))
        cell.postUserAvatar.sd_setImage(with: URL(string: self.mainImageURL))
        cell.postUserFirstNameLastName.text = "Svyatoslav Bykov"
        //cell.postUserFirstNameLastName =
        //self.mainImage.image
//        cell.delegate = self

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func didTapCommentsButton(sender: PictureCell) {
        let commentsControler = CommentsController()
        if let post = sender.post {
            commentsControler.post = post
        }
        navigationController?.pushViewController(commentsControler, animated: true)
    }
    
    func didTapLikeButton(sender: PictureCell) {
        
        //guard let indexPath = tableView.indexPath(for: sender) else { return }
        var post = self.post//posts[indexPath.item]
        guard let owner_id = sender.post?.ownerId else { return }
        guard let item_id = sender.post?.postId else { return }
        guard let access_key = sender.post?.access_key else { return }
        
        var url: URL?
        
        if post?.userLikes == 0 {
            url = vkApiUrlBuilder(vkApiMethod: "likes.add",
                                  queryItems: ["type":"photo",
                                               "owner_id": String(owner_id),
                                               "item_id": String(item_id),
                                               "access_key": String(access_key),
                                               "access_token":VKSdk.accessToken().accessToken])
        }
        else {
            url = vkApiUrlBuilder(vkApiMethod: "likes.delete",
                                  queryItems: ["type":"photo",
                                               "owner_id": String(owner_id),
                                               "item_id": String(item_id),
                                               "access_key": String(access_key),
                                               "access_token":VKSdk.accessToken().accessToken])
        }
        
        if let url = url {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                post?.userLikes = 1 - (post?.userLikes)!
                self.post = post
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.tableView?.reloadData()
                })
                
            }).resume()
        }
    }

    
//    func didTapCommentsButton(sender: PictureCell) {
//        let commentsController = CommentsController()
//        navigationController?.pushViewController(commentsController, animated: true)
//    }
    

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
