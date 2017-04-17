//
//  LoginController.swift
//  InstaVK
//
//  Created by Svyatoslav Bykov on 16.04.17.
//  Copyright © 2017 Svyatoslav Bykov. All rights reserved.
//

import UIKit
import VK_ios_sdk

let applicationID = "5986161"
let nextSegue: String = "loggedSegue"
var SCOPE: [Any]? = nil
let okButton = UIAlertAction(title: "OK", style: .destructive, handler: { (action) -> Void in }) //TO-DO move to helper class


class LoginController: UIViewController, VKSdkDelegate, VKSdkUIDelegate {

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
        performSegue(withIdentifier: nextSegue, sender: self)
    }
    
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError) {
        let vc = try? VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: navigationController?.topViewController)
    }
    
    func vkSdkTokenHasExpired(_ expiredToken: VKAccessToken) {
        VKSdk.authorize(SCOPE)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        if (result.token != nil) {
            startWorking()
        }
        else if (result.error != nil) {
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
    
    func vkSdkShouldPresent(_ controller: UIViewController) {
        present(controller, animated: true, completion: nil)
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
