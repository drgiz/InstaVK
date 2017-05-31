//
//  PhotoViewController.swift
//  InstaVK
//
//  Created by Никита on 28.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import Photos

enum FetchMode {
    case onePhotoFetchMode
    case manyPhotosFetchMode
}

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: PhotoCollectionView!
    @IBOutlet weak var mainImageView: UIImageView!
    let headerIdentifier = "headerPhoto"
    let cellIdentifier = "photoGridCell"
    let imageViews = [UIImageView]()
    var images = NSMutableArray()
    var tempIndex = Int()
    let offset = 20
    var indexPath = IndexPath()
    
    //var header = HeaderPhotoView()
    //var indexPath123 = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tempIndex = 0
        self.fetchPhotos(mode: FetchMode.onePhotoFetchMode, index: 0)
        self.fetchPhotos(mode: FetchMode.manyPhotosFetchMode, index: 0)
    }
    
    func fetchPhotos(mode: FetchMode, index: Int){
        var tempIndex = index
        let imgManager = PHCachingImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        if fetchResult.count > 0 {
            /*var indexWithOffset = self.tempIndex + self.offset
             
             if indexWithOffset > fetchResult.count {
             indexWithOffset = fetchResult.count
             }
             
             if self.tempIndex == fetchResult.count {
             return
             }*/
            
            switch mode {
                
            case .onePhotoFetchMode:
                imgManager.requestImage(for: fetchResult.object(at: tempIndex), targetSize: CGSize.init(width:view.frame.width, height: 356), contentMode: PHImageContentMode.aspectFill, options: requestOptions, resultHandler: { (image, _) in
                    
                    self.mainImageView.image = image
                    //self.images.add(image ?? #imageLiteral(resourceName: "Image"))
                })
                break
                
            case .manyPhotosFetchMode:
                while tempIndex < fetchResult.count {
                    imgManager.requestImage(for: fetchResult.object(at: tempIndex), targetSize: CGSize.init(width:100, height:100), contentMode: PHImageContentMode.aspectFill, options: requestOptions, resultHandler: { (image, _) in
                        
                        self.images.add(image ?? #imageLiteral(resourceName: "Image"))
                        tempIndex += 1
                    })}
                break
            
            //self.collectionView?.reloadData()
        }
        }
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    /*    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind{
        case UICollectionElementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderPhotoView
            
            header.mainPhotoImageView.image = self.images.firstObject as? UIImage
            return header
            
        default:
            
            assert(false, "unexpected element kind")
        }
    }
    */
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoGridCell
        

        cell.photoImageView.image = images.object(at: indexPath.row) as? UIImage
        cell.photoImageView.layer.cornerRadius = 7
        cell.photoImageView.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/4 - 1, height: collectionView.frame.width/4 - 1)
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! PhotoGridCell
        selectedCell.photoImageView.alpha = 0.5
        
        fetchPhotos(mode: FetchMode.onePhotoFetchMode, index: indexPath.row)
        //self.mainImageView.image = cell.photoImageView.image
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      
            //let deselectedCell = collectionView.cellForItem(at: self.indexPath) as! PhotoGridCell
        
            //deselectedCell.photoImageView.alpha = 1
        
        //let rt = indexPath
        //let cell = collectionView.cellForItem(at: indexPath) as? PhotoGridCell
        //cell?.photoImageView.alpha = 1
    }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueForSent" {
            let controller = segue.destination as! SentPhotoTableViewController
            controller.img = self.mainImageView.image!
            //controller.commentTextView.text = "hello world!!!"
            //controller.sentPhoto.image = self.mainImageView.image
            //controller.sentPhoto.image = #imageLiteral(resourceName: "Image-1")//self.images.object(at: (collectionView.indexPathsForSelectedItems?.first?.row)!) as! UIImage
        }
    }
    
    
    }
