//
//  PhotoController.swift
//  InstaVK
//
//  Created by Никита on 27.03.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import Photos

class PhotoController: UICollectionViewController {
   
    //let imagePicker = UIImagePickerController()
    let headerIdentifier = "headerPhoto"
    let cellIdentifier = "photoGridCell"
    let imageViews = [UIImageView]()
    var images = NSMutableArray()
    var tempIndex = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tempIndex = 0
        self.fetchPhotos(index: self.tempIndex)
        }
            
    func fetchPhotos(index:Int){
        
        
        let imgManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        imgManager.requestImage(for: fetchResult.object(at: self.tempIndex), targetSize: view.frame.size, contentMode: PHImageContentMode.aspectFill, options: requestOptions, resultHandler: { (image, _) in
            
            self.images.add(image ?? #imageLiteral(resourceName: "Image-1"))
            //print(fetchResult.count)
            
            if self.tempIndex < fetchResult.count - 1 {
                
                self.tempIndex = self.tempIndex + 1
                self.fetchPhotos(index: self.tempIndex)
            }
        })
        
        //if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions) {
            
        }
        // Do any additional setup after loading the view.
        //imagePicker.delegate = self
        //imagePicker.allowsEditing = false
       // imagePicker.sourceType = .savedPhotosAlbum
        //imagePicker.
        //present(imagePicker, animated: true, completion: nil)
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //imageView.contentMode = .ScaleAspectFit
            //imageView.image = pickedImage
        //}
        
       // imageViews = info[]
        
        //dismiss(animated: true, completion: nil)
}

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderPhotoView
        header.mainPhotoImageView.image = self.images.firstObject as? UIImage
        //header.profileHeaderImage.layer.contents = #imageLiteral(resourceName: "Image").cgImage
        //header.profileHeaderImage.layer.cornerRadius = 50
        //header.profileHeaderImage.layer.borderColor = UIColor.black.cgColor
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoGridCell
        
        cell.photoImageView.image = images.object(at: indexPath.row) as? UIImage
        
        /*if arc4random() % 2 == 1 {
            cell.photoImageView.image = #imageLiteral(resourceName: "Image-1")
        } else {
            cell.photoImageView.image = #imageLiteral(resourceName: "Image")
        }*/
        
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
