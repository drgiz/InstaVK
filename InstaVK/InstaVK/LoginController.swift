//
//  LoginController.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 16.04.17.
//  Copyright © 2017 Svyatoslav Bykov. All rights reserved.
//

import UIKit
import VK_ios_sdk

fileprivate let applicationID = "5986161"
fileprivate var SCOPE: [Any]? = nil
let okButton = UIAlertAction(title: "OK", style: .destructive, handler: nil) //TO-DO move to helper class


class LoginController: UIViewController {

    override func viewDidLoad() {
        SCOPE = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_PHOTOS, VK_PER_EMAIL, VK_PER_MESSAGES]
        super.viewDidLoad()
        VKSdk.initialize(withAppId: applicationID).register(self) // Initialize VK SDK with our app id (5986161)
        VKSdk.instance().uiDelegate = self
        VKSdk.wakeUpSession(SCOPE, complete: {(_ state: VKAuthorizationState, _ error: Error?) -> Void in
            if state == VKAuthorizationState.authorized {
                self.startWorking()
            }
            else if error != nil {
                let alertVC = UIAlertController(title: "", message: error.debugDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertVC.addAction(okButton)
                self.present(alertVC, animated: true, completion: nil)
            }
            
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginWithVKApp(_ sender: UIButton) {
        VKSdk.authorize(SCOPE)
    }
    
    @IBAction func loginWithLoginAndPassword(_ sender: UIButton) {
        VKAuthorizeController.presentForAuthorize(withAppId: applicationID, andPermissions: SCOPE, revokeAccess: false, displayType: VK_DISPLAY_IOS)
    }
    
    
    func startWorking() {
        let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = myTabBar
    }
    
    
    func vkSdkTokenHasExpired(_ expiredToken: VKAccessToken) {
        VKSdk.authorize(SCOPE)
    }
    
}

extension LoginController: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        if (result.token != nil) {
            startWorking()
        } else if (result.error != nil) {
            let alertVC = UIAlertController(title: "", message: "Access denied\n\(result.error)", preferredStyle: UIAlertControllerStyle.alert)
            alertVC.addAction(okButton)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        let alertVC = UIAlertController(title: "", message: "Access denied", preferredStyle: UIAlertControllerStyle.alert)
        alertVC.addAction(okButton)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension LoginController: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError) {
        if let captchaVC = VKCaptchaViewController.captchaControllerWithError(captchaError) {
            present(captchaVC, animated: true, completion: nil)
        }
    }
}
