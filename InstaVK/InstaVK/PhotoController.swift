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
   
    let headerIdentifier = "headerPhoto"
    let cellIdentifier = "photoGridCell"
    let imageViews = [UIImageView]()
    var images = NSMutableArray()
    var tempIndex = Int()
    let offset = 20
    //var indexPath123 = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tempIndex = 0
        self.fetchPhotos()
        }
            
    func fetchPhotos(){
        let imgManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        if fetchResult.count > 0 {
            var indexWithOffset = self.tempIndex + self.offset
            
            if indexWithOffset > fetchResult.count {
                indexWithOffset = fetchResult.count
            }
            
            if self.tempIndex == fetchResult.count {
                return
            }
            
            while self.tempIndex < indexWithOffset {
                imgManager.requestImage(for: fetchResult.object(at: self.tempIndex), targetSize: view.frame.size, contentMode: PHImageContentMode.aspectFill, options: requestOptions, resultHandler: { (image, _) in
                    
                    self.images.add(image ?? #imageLiteral(resourceName: "Image"))
                    self.tempIndex += 1
                })
            }
            
            self.collectionView?.reloadData()
        }
        }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind{
            case UICollectionElementKindSectionHeader:
                
            //self.indexPath123 = indexPath
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderPhotoView
            
            header.mainPhotoImageView.image = self.images.firstObject as? UIImage
            return header

            default:
                
            assert(false, "unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoGridCell
        
        cell.photoImageView.image = images.object(at: indexPath.row) as? UIImage

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoGridCell
       let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderPhotoView
        header.mainPhotoImageView.image = cell.photoImageView.image
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 19 {
            fetchPhotos()
        }
    }
}
