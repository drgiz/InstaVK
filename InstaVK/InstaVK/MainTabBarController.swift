//
//  MainTabBarController.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 14.05.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import VK_ios_sdk

class MainTabBarController: UITabBarController {
    
    let loginScreenIdentifier = "LoginViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        print(VKSdk.isLoggedIn())
        if VKSdk.isLoggedIn() == false {
                let lc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.loginScreenIdentifier)
                let navController = UINavigationController(rootViewController: lc)
                //self.window?.rootViewController = lc
                self.present(navController, animated: true, completion: nil)
            }

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
