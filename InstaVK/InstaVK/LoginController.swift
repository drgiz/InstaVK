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
let nestSegue: String = "loggedSegue"
var SCOPE: [Any]? = nil


class LoginController: UIViewController, VKSdkDelegate, VKSdkUIDelegate {

    override func viewDidLoad() {
        SCOPE = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES]
        super.viewDidLoad()
        VKSdk.initialize(withAppId: applicationID).register(self) // Initialize VK SDK with our app id (5986161)
        VKSdk.instance().uiDelegate = self
        VKSdk.wakeUpSession(SCOPE, complete: {(_ state: VKAuthorizationState, _ error: Error?) -> Void in
            if state == VKAuthorizationState.authorized {
                self.startWorking()
            }
            else if error != nil {
                //TO-DO: Fix depricated method to smth like: 
                // UIAlertController(title: "", message: error.debugDescription, preferredStyle: UIAlertControllerStyle.alert)
                UIAlertView(title: "", message: error.debugDescription, delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "Ok", otherButtonTitles: "").show()
                
            }
            
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startWorking() {
        performSegue(withIdentifier: nestSegue, sender: self)
    }
    
    @IBAction func authorize(_ sender: Any) {
        VKSdk.authorize(SCOPE)
    }
    
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError) {
        let vc = try? VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: navigationController?.topViewController)
    }
    
    func vkSdkTokenHasExpired(_ expiredToken: VKAccessToken) {
        authorize(self)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        if (result.token != nil) {
            startWorking()
        }
        else if (result.error != nil) {
            //TO-DO: Fix depricated UIAlertView
            UIAlertView(title: "", message: "Access denied\n\(result.error)", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "Ok", otherButtonTitles: "").show()
        }
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        //TO-DO: Fix depricated UIAlertView
        UIAlertView(title: "", message: "Access denied", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "Ok", otherButtonTitles: "").show() 
        navigationController?.popToRootViewController(animated: true)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController) {
        navigationController?.topViewController?.present(controller, animated: true, completion: { _ in })
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
