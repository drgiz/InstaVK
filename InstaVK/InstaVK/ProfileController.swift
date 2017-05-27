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


class ProfileController: UICollectionViewController {
    
    var posts = [Post]()
    var profiles = [Int:Profile]()

    
    @IBAction func pressFollowersButton(_ sender: Any) {
        let followersController = FollowersController.init(id: "id")
        //VKRequest *request =
        
        
        
        navigationController?.pushViewController(followersController, animated: true)
        //vs = storyboard?.instantiateViewController(withIdentifier: "ProfileControllerIdentifier") as! ProfileController
        //navigationController?.pushViewController(vs, animated: true)
        
    }
    @IBAction func pressFollowingButton(_ sender: Any) {
        let followingController = FollowingController()
        navigationController?.pushViewController(followingController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier1)
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier2)

        // Do any additional setup after loading the view.
        fetchPosts()
    }
    
    func fetchPosts() {
        guard let vkAccessToken = VKSdk.accessToken().accessToken else {
            return
        }
        guard let url = vkApiUrlBuilder(vkApiMethod: "photos.get",
                                        queryItems: ["album_id":"profile",
                                                     "count":"10",
                                                     "access_token":vkAccessToken])
            else {
                return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                //в JSONе приходит отдельный словарь на профайлы и отдельный на фотографии
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(json)
                guard let jsonDict = json as? [String: Any] else { return }
               // guard let responseDict = jsonDict["response"] as? [String: Any] else { return }
                //guard let itemsDict = responseDict["items"] as? [[String: Any]] else { return }
                //добавляем профайл в словарь наших профайлов чтобы подтягивать оттуда информацию о пользователе
                //for item in itemsDict {
                //    if let profileId = item["uid"] as? Int {
                //        self.profiles[profileId] = Profile(dictionary: profile)
                //    }
               // }
                guard let itemsDict = jsonDict["response"] as? [[String: Any]] else { return }
                //из items вытягиваем информацию о постах и добавляем в наш массив постов
                for item in itemsDict {
                    //if let photosArray = item["photo_130"] as? [Any] {
                        //for photo in photosArray {
                            if let itemDictionary = item as? [String : Any] {
                                let post = Post(dictionary: itemDictionary)
                                self.posts.append(post)
                            //}
                        //}
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HeaderProfileView
        header.profileHeaderImage.image = #imageLiteral(resourceName: "Kevin")
        header.profileHeaderImage.layer.cornerRadius = 50.0
        header.profileHeaderImage.clipsToBounds = true
        //header.profileHeaderImage.layer.contents = #imageLiteral(resourceName: "Image").cgImage
        //header.profileHeaderImage.layer.cornerRadius = 50
        //header.profileHeaderImage.layer.borderColor = UIColor.black.cgColor
        
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
          let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath) as? ProfileGridCell
        cell?.imageCell.sd_setImage(with: URL(string: posts[indexPath.row].imageUrl_130))
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath)
        
        //if let newsCell = cell as? ProfileGridCell {
        //    newsCell.post = posts[indexPath.row]
        //}
           // newsCell.delegate = self
           // if let postOwnerFirstName = profiles[posts[indexPath.row].ownerId]?.firstName, let postOwnerSecondName = profiles[posts[indexPath.row].ownerId]?.lastName {
            //    newsCell.postUserFirstNameLastName.text = postOwnerFirstName + " " + postOwnerSecondName
            //} else {
             //   newsCell.postUserFirstNameLastName.text = "Unavailable"
           // }
           // if let postOwnerAvatarUrl = profiles[posts[indexPath.row].ownerId]?.photoUrl {
           //     newsCell.postUserAvatar.setShowActivityIndicator(true)
           //     newsCell.postUserAvatar.setIndicatorStyle(.gray)
           //     newsCell.postUserAvatar.sd_setImage(with: URL(string: postOwnerAvatarUrl))
           // } else {
           //     newsCell.postUserAvatar.image = #imageLiteral(resourceName: "error404")
           // }

        
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pictureController = PictureController()
        navigationController?.pushViewController(pictureController, animated: true)
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
