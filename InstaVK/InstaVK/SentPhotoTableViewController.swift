//
//  SentPhotoTableViewController.swift
//  InstaVK
//
//  Created by Никита on 29.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import VK_ios_sdk

class SentPhotoTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var sentPhoto: UIImageView!
    
    var img = UIImage()
    var tempCounter = 0
    var photo = UserPhoto(dictionary: ["" : ""])
    
    @IBAction func didTapSendButton(_ sender: Any) {
        
        let parameters = VKImageParameters()
        parameters.imageType = VKImageTypeJpg
        
      /*  let requestServer = VKApi.photos().getUploadServer(244930054)
        requestServer?.execute(resultBlock: { (response) in
            
            //print(response?.json)
            let serverDict = response?.json as? [String: Any]
            var photos = [UIImage]()
            photos.append(self.sentPhoto.image!)
            
            let requestPhoto =
                VKRequest.photoRequest(withPostUrl: serverDict?["upload_url"] as? String,
                                                      withPhotos: photos)
            
            requestPhoto?.execute(resultBlock: { (response) in
                print(response?.json)
            }, errorBlock: { (error) in
                
            })
            
            
        }, errorBlock: { (error) in
            
        })*/
        
       let request = VKApi.uploadAlbumPhotoRequest(self.sentPhoto.image, parameters: parameters, albumId: 244930054, groupId: 0)
        
        request?.execute(resultBlock: { (dictionary) in
            
            let dict = dictionary?.json as? [Any]
            for item in dict!{
                let dictPhoto = item as? [String : Any]
                self.photo = UserPhoto.init(dictionary: dictPhoto!)
                
                
                let commentRequest = VKApi.request(withMethod: "photos.createComment",
                                                   andParameters:["owner_id": self.photo.ownerId,
                                                                  "photo_id":self.photo.photoId,
                                                                  "message":self.commentTextView.text])
                
                commentRequest?.execute(resultBlock: { (response) in
                    
                    self.navigationController?.popToRootViewController(animated: true)
                    
                }, errorBlock: { (error) in
                    
                })
            }
            
        }, errorBlock: { (error) in
            
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentTextView.delegate = self
        self.sentPhoto.image = self.img

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if self.tempCounter == 0 {
            self.commentTextView.text = ""
            self.tempCounter += 1
        }
        self.commentTextView.textColor = UIColor.black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
