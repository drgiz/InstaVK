//
//  AppDelegate.swift
//  InstaVK
//
//  Created by Никита on 22.03.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import CoreData
import VK_ios_sdk

fileprivate var SCOPE: [Any]? = nil

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginScreenIdentifier = "LoginViewController"
    let mainTabBarIdentifier = "mainTabBar"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        VKSdk.initialize(withAppId: applicationID) // Initialize VK SDK with our app id (5986161)
        // Override point for customization after application launch.
        
        SCOPE = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_PHOTOS, VK_PER_EMAIL, VK_PER_MESSAGES]
        VKSdk.wakeUpSession(SCOPE, complete: {(_ state: VKAuthorizationState, _ error: Error?) -> Void in
            if error != nil {
                let alertVC = UIAlertController(title: "", message: error.debugDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertVC.addAction(okButton)
                self.window?.rootViewController?.present(alertVC, animated: true, completion: nil)
            }
            else if state == VKAuthorizationState.authorized{
                let lc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.mainTabBarIdentifier)
                self.window?.rootViewController = lc

            }
            else if state != VKAuthorizationState.authorized {
                let lc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.loginScreenIdentifier)
                self.window?.rootViewController = lc
                //self.present(lc, animated: true, completion: nil)
            }
        })
        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplicationOpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "InstaVK")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

