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
    var profiles = [Int:Profile]()
    
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
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                guard let jsonDict = json as? [String: Any] else { return }
                guard let responseDict = jsonDict["response"] as? [String: Any] else { return }
                guard let profilesDict = responseDict["profiles"] as? [[String: Any]] else { return }
                for profile in profilesDict {
                    if let profileId = profile["id"] as? Int {
                        self.profiles[profileId] = Profile(dictionary: profile)
                    }
                }
                guard let commentsDict = responseDict["items"] as? [[String:Any]] else { return }
                for comment in commentsDict {
                        let comment = Comment(dictionary: comment)
                        self.comments.append(comment)
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    self.tableView?.reloadData()
                })
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
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath)
        if let commentsCell = cell as?  CommentCell {
            if let postOwnerAvatarUrl = profiles[comments[indexPath.row].ownerId]?.photoUrl_50 {
                commentsCell.avatarImage.setShowActivityIndicator(true)
                commentsCell.avatarImage.setIndicatorStyle(.gray)
                commentsCell.avatarImage.sd_setImage(with: URL(string: postOwnerAvatarUrl))
            } else {
                commentsCell.avatarImage.image = #imageLiteral(resourceName: "error404")
            }
            if let commentOwnerFirstName = profiles[comments[indexPath.row].ownerId]?.firstName, let commentOwnerSecondName = profiles[comments[indexPath.row].ownerId]?.lastName {
                commentsCell.userFirstLastName.setTitle(commentOwnerFirstName + " " + commentOwnerSecondName, for: .normal)
            } else {
                commentsCell.userFirstLastName.setTitle("Unavailable", for: .normal)
            }
            
            commentsCell.commentText.text = comments[indexPath.row].text
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
