//
//  NewsController.swift
//  InstaVK
//
//  Created by Никита on 27.03.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import VK_ios_sdk
import SDWebImage

fileprivate var SCOPE: [Any]? = nil

class NewsController: UITableViewController, PictureCellDelegate {
    
    let identifier = "PictureCellTest"
    let loginScreenIdentifier = "LoginViewController"
    
    var imageURLs = ["http://www.pravmir.ru/wp-content/uploads/2015/11/image-original.jpg", "http://redcat7.ru/wp-content/uploads/2014/01/motivator-s-kotom-pogovori.jpg", "https://4tololo.ru/files/styles/large/public/images/20141911123228.jpg?itok=gdc3Arzv", "http://www.sostav.ru/blogs/images/posts/15/29708.jpg", "http://www.nexplorer.ru/load/Image/1113/koshki_9.jpg", "http://storyfox.ru/wp-content/uploads/2015/11/shutterstock_265075847-696x528.jpg"]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        let nib = UINib (nibName: "PictureCellTest", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        SCOPE = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_PHOTOS, VK_PER_EMAIL, VK_PER_MESSAGES]
        VKSdk.wakeUpSession(SCOPE, complete: {(_ state: VKAuthorizationState, _ error: Error?) -> Void in
            if state != VKAuthorizationState.authorized {
                let lc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.loginScreenIdentifier)
                self.present(lc, animated: true, completion: nil)
            }
            else if error != nil {
                let alertVC = UIAlertController(title: "", message: error.debugDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertVC.addAction(okButton)
                self.present(alertVC, animated: true, completion: nil)
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageURLs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let newsCell = cell as? PictureCellTest {
        newsCell.delegate = self
        newsCell.postUserAvatar.image = #imageLiteral(resourceName: "avatarQuadro")
        //TEST
        let imageView = newsCell.postPicture!
        imageView.sd_setImage(
            with: URL(string: imageURLs[indexPath.row]),
            completed: { (image, error, cached, url) in
            let scale : CGFloat = image!.size.width/UIScreen.main.bounds.width
            newsCell.pictureHeight.constant = image!.size.height/scale
            })
        }
        //cell.avatarImageView.image = #imageLiteral(resourceName: "Image")
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let scale : CGFloat = #imageLiteral(resourceName: "Image").size.width/UIScreen.main.bounds.width
//        return #imageLiteral(resourceName: "Image").size.height/scale + 80 + 32
//    }
    
    func didTapButton(sender: UITableViewCell) {
        let commentsControler = CommentsController()
        navigationController?.pushViewController(commentsControler, animated: true)
    }
    
    func startWorking() {
        
    }
    
    
    // MARK: LogOut button for test purposes
    @IBAction func logOut(_ sender: Any) {
        VKSdk.forceLogout()
        let lc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.present(lc, animated: true, completion: nil)
    }
    
    
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
