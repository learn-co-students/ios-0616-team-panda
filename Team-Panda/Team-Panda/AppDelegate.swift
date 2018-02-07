    //
    //  AppDelegate.swift
    //  Team-Panda
    //
    //  Created by Lloyd W. Sykes on 8/4/16.
    //  Copyright © 2016 Flatiron School. All rights reserved.
    //
    
    import UIKit
    import FirebaseAuth
    import FirebaseCore
    
    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow?
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            // Setting up Firebase
            
            FirebaseApp.configure()
            
            return true
        }
        
        func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
            return true
        }
    }
