    //
//  AppDelegate.swift
//  Team-Panda
//
//  Created by Lloyd W. Sykes on 8/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Setting up Firebase
        FIRApp.configure()
        // Setting up Google sign-in
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
                
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let google = GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
        let facebook = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return facebook || google
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        // Confirms Google login, adds Google user to Firebase
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let googleAuth = user.authentication
        let googleCredential = FIRGoogleAuthProvider.credentialWithIDToken(googleAuth.idToken, accessToken: googleAuth.accessToken)
        FIRAuth.auth()?.signInWithCredential(googleCredential, completion: { (googleUser, error) in
            if let error = error {
                print("There was an issue with the authorizing the googleCredential for Firebase in AppDelegate: \(error.localizedDescription)")
            }
            if let googleUser = googleUser {
                print("Google user's email: \(googleUser.email), Google user's Display Name: \(googleUser.displayName), Google user's photoURL: \(googleUser.photoURL)")
                if let googleUserEmail = googleUser.email {
                    let values = ["email": googleUserEmail,
                    ]
                    let loginViewController = LoginViewController()
                    loginViewController.ref = FIRDatabase.database().referenceFromURL("https://career-options.firebaseio.com/")
                    let usersReference = loginViewController.ref.child("users")
                    usersReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            // Alert user there was an issue
                            print("There was an issue with creating a new Google user in the Firebase database: \(error?.localizedDescription)")
                            
                            
                            
                        }

                        // Has to go to SignUpPageViewController

                        print("Google user successfully saved into the Firebase database!")
                        
                        
                    })
                }
                print("Google user's display name: \(googleUser.displayName)\nGoogle user's email: \(googleUser.email)\nGoogle user's photoURL: \(googleUser.photoURL)")
            }
        })
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!, withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    // Method Google recommends for iOS 9+
    //    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    //        let google =  GIDSignIn.sharedInstance().handleURL(url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    //
    //        return google
    //    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}