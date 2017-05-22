//
//  CommentsController.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 03.04.17.
//  Copyright © 2017 Svyatoslav Bykov. All rights reserved.
//

import UIKit
import VK_ios_sdk

class CommentsController: UITableViewController {
    
    var post: Post?
    var comments = [Comment]()
    
    let commentCellIdentifier = "CommentCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib (nibName: "CommentCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: commentCellIdentifier)
        
        fetchComments()
    }
    
    fileprivate func fetchComments() {
        guard let vkAccessToken = VKSdk.accessToken().accessToken else {
            return
        }
        guard let ownerId = post?.ownerId else { return }
        guard let photoId = post?.postId else { return }
        guard let access_key = post?.access_key else { return }
        guard let url = vkApiUrlBuilder(vkApiMethod: "photos.getComments",
                                        queryItems: ["owner_id": String(ownerId),
                                                     "photo_id": String(photoId),
                                                     "access_key": access_key,
                                                     "access_token": vkAccessToken,
                                                     "extended": "1",
                                                     "count": "10",
                                                     "sort": "asc",
                                                     "v": "5.58"])
            else {
            return
        }
        
        print(url)
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                guard let jsonDict = json as? [String: Any] else { return }
                guard let responseDict = jsonDict["response"] as? [String: Any] else { return }
                print(responseDict)
            } catch let jsonError {
                print(jsonError)
            }
        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath)
        if let commentsCell = cell as?  CommentCell {
            commentsCell.avatarImage.image = #imageLiteral(resourceName: "Image")
            commentsCell.commentText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris"
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
