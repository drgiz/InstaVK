//
//  CollectionTest.swift
//  InstaVK
//
//  Created by Никита on 31.03.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

private let reuseIdentifier1 = "cell1"
private let reuseIdentifier2 = "cell2"

class ProfileController: UICollectionViewController {
    
    @IBAction func pressFollowersButton(_ sender: Any) {
        let followersController = FollowersController.init(id: "id")
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
        
        return 50
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HeaderProfileView
        header.profileHeaderImage.image = #imageLiteral(resourceName: "Image")
        //header.profileHeaderImage.layer.contents = #imageLiteral(resourceName: "Image").cgImage
        //header.profileHeaderImage.layer.cornerRadius = 50
        //header.profileHeaderImage.layer.borderColor = UIColor.black.cgColor
        
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
          let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath) as! ProfileGridCell
        cell.imageCell.image = #imageLiteral(resourceName: "Image")
        
        return cell
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
