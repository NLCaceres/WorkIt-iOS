//
//  AppDelegate.swift
//  WorkIt
//
//  Created by Nicholas L Caceres on 11/17/16.
//  Copyright © 2016 Nicholas L Caceres. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import GoogleSignIn
//import FBSDKCoreKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var tabBar: UITabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = "998193705224-lvrnlsm43vf2sgjf48nihv5tvk3o612p.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyDssHkfj5_ozOzieJMvhUsC3zaCVJ0V8c4")
        GMSPlacesClient.provideAPIKey("AIzaSyDssHkfj5_ozOzieJMvhUsC3zaCVJ0V8c4")
        
        configureTabBar()
        configureNavBar()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[.sourceApplication] as? String,
                                                 annotation: options[.annotation])
    }
//    // iOS 8 and lower
//    func application(application: UIApplication,
//                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
//        var options: [String: AnyObject] = [UIApplication.OpenURLOptionsKey: sourceApplication,
//                                            UIApplication.OpenURLOptionsKey: annotation]
//        return GIDSignIn.sharedInstance().handleURL(url,
//                                                    sourceApplication: sourceApplication,
//                                                    annotation: annotation)
//    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = self.window?.rootViewController as! UITabBarController
            tabBar.selectedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
    
    func configureTabBar() {
        tabBar = self.window?.rootViewController as? UITabBarController
        if let tabBar = tabBar {
            tabBar.selectedIndex = 2
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 0x99, green: 0x00, blue: 0x00, alpha: 0xFF)], for: .selected)
    }
    func configureNavBar() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.barTintColor = UIColor(red:0.11, green:0.15, blue:0.45, alpha:1.0) // Loyola Blue
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        let handled : Bool = FBSDKApplicationDelegate.sharedInstance().application(
//            app,
//            open: url, // as URL
//            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String,
//            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//        )
//        
//        return handled
//    }

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
        let container = NSPersistentContainer(name: "WorkIt")
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

