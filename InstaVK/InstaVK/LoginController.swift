//
//  LoginController.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 16.04.17.
//  Copyright © 2017 Svyatoslav Bykov. All rights reserved.
//

import UIKit
import VK_ios_sdk

fileprivate var SCOPE: [Any]? = nil
let okButton = UIAlertAction(title: "OK", style: .destructive, handler: nil) //TODO move to helper class


let mainTabBarIdentifier = "mainTabBar"


class LoginController: UIViewController {
    
    var window: UIWindow?

    override func viewDidLoad() {
        SCOPE = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_PHOTOS, VK_PER_EMAIL, VK_PER_MESSAGES, VK_PER_OFFLINE]
        super.viewDidLoad()
        VKSdk.instance().register(self) 
        VKSdk.instance().uiDelegate = self
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
    
    func vkSdkTokenHasExpired(_ expiredToken: VKAccessToken) {
        VKSdk.authorize(SCOPE)
    }
    
}

extension LoginController: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        if (result.token != nil) {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: mainTabBarIdentifier) as! UITabBarController
            UIApplication.shared.keyWindow?.rootViewController = viewController
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
