//
//  CollectionTest.swift
//  InstaVK
//
//  Created by Никита on 31.03.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import VK_ios_sdk

private let reuseIdentifier1 = "cell1"
private let reuseIdentifier2 = "cell2"


class ProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var firstAndLastNameBarItem: UIBarButtonItem!
    var posts = [Post]()
    var profiles = [Int:Profile]()
    var ownerId : String?
    var avatarURL = String()
    var firstName = String()
    var lastName = String()
    
    @IBAction func pressFollowersButton(_ sender: Any) {
        let followersController = FollowersController.init(id: "id")
        navigationController?.pushViewController(followersController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        fetch()
    }
    
    func fetch() {
        
        guard let vkAccessToken = VKSdk.accessToken().accessToken else {
            return
        }
        
        fetchPhotos(withVKAccessToken: vkAccessToken)
        fetchInfoUser(withVKAccessToken: vkAccessToken)
    }
    
    func fetchPhotos(withVKAccessToken vkAccessToken: String!) {
        
        let url : URL?
        
        if let owner_Id = self.ownerId {
            url = vkApiUrlBuilder(vkApiMethod: "photos.getAll",
                                            queryItems: ["skip_hidden":"1",
                                                         "owner_id":owner_Id,
                                                         "count":"350",
                                                         "no_service_albums":"0",
                                                         "access_token":vkAccessToken])
            
        } else {
            url = vkApiUrlBuilder(vkApiMethod: "photos.getAll",
                                            queryItems: ["skip_hidden":"1",
                                                         "count":"350",
                                                         "no_service_albums":"0",
                                                         "access_token":vkAccessToken])
            }
        
        guard (url != nil) else {return}
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                guard let jsonDict = json as? [String: Any] else { return }
                
                if let itemsDict = jsonDict["response"] as? [Any] {
                    for item in itemsDict {
                        if let itemDictionary = item as? [String : Any] {
                            let post = Post(dictionary: itemDictionary)
                            //print(post)
                            self.posts.append(post)
                        }
                    }
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    self.collectionView?.reloadData()
                })
            } catch let jsonError {
                print(jsonError)
            }
        }) .resume()
    }
    
    func fetchInfoUser(withVKAccessToken vkAccessToken: String!) {
    
        let url : URL?
        
        if let owner_Id = self.ownerId {
            url = vkApiUrlBuilder(vkApiMethod: "users.get",
                                  queryItems: ["user_id":owner_Id,
                                               "fields":"photo_medium",
                                               "name_case":"nom",
                                               "access_token":vkAccessToken])
            
        } else {
            url = vkApiUrlBuilder(vkApiMethod: "users.get",
                                  queryItems: ["fields":"photo_medium",
                                               "name_case":"nom",
                                               "access_token":vkAccessToken])
        }
        
        guard (url != nil) else {return}
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                //print(json)
                guard let jsonDict = json as? [String: Any] else { return }
                
                if let itemsDict = jsonDict["response"] as? [Any] {
                    for item in itemsDict {
                        if let itemDictionary = item as? [String : Any] {
                            let user = User(dictionary: itemDictionary)
                            self.avatarURL = user.photoMediumURL
                            self.firstName = user.firstName
                            self.lastName = user.lastName
                        }
                    }
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    self.collectionView?.reloadData()
                })
            } catch let jsonError {
                //print(jsonError)
            }
        }) .resume()
    }


    //MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HeaderProfileView
        header.profileHeaderImage.sd_setImage(with: URL(string: avatarURL))
        header.profileHeaderImage.layer.cornerRadius = 50.0
        header.profileHeaderImage.clipsToBounds = true
        header.firstAndLastNameLabel.text = self.firstName + " " + self.lastName
        self.firstAndLastNameBarItem.title = self.firstName + " " + self.lastName
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
          let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath) as? ProfileGridCell
        cell?.imageCell.sd_setImage(with: URL(string: posts[indexPath.row].imageUrl_130))
        cell?.imageCell.layer.cornerRadius = 10.0
        cell?.imageCell.clipsToBounds = true
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pictureController = PictureController()
        //pictureController.mainImage.setShowActivityIndicator(true)
        //pictureController.mainImage.setIndicatorStyle(.gray)
        pictureController.post = posts[indexPath.row]
        //mainImage.sd_setImage(with: URL(string: posts[indexPath.row].imageUrl_807))
        navigationController?.pushViewController(pictureController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/3 - 1, height: collectionView.frame.width/3 - 1)
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
