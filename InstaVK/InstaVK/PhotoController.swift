//
//  PhotoController.swift
//  InstaVK
//
//  Created by Никита on 27.03.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

class PhotoController: UICollectionViewController {
   
    
    let headerIdentifier = "headerPhoto"
    let cellIdentifier = "photoGridCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderPhotoView
        header.mainPhotoImageView.image = #imageLiteral(resourceName: "Image")
        //header.profileHeaderImage.layer.contents = #imageLiteral(resourceName: "Image").cgImage
        //header.profileHeaderImage.layer.cornerRadius = 50
        //header.profileHeaderImage.layer.borderColor = UIColor.black.cgColor
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoGridCell
        
        if arc4random() % 2 == 1 {
            cell.photoImageView.image = #imageLiteral(resourceName: "Image-1")
        } else {
            cell.photoImageView.image = #imageLiteral(resourceName: "Image")
        }
        
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoGridCell
       let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderPhotoView
        header.mainPhotoImageView.image = cell.photoImageView.image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
