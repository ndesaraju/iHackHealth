//
//  AppDelegate.swift
//  PediatricPancreas_Storyboard
//
//  Created by Reet Mishra on 2/19/20.
//  Copyright © 2020 Example Company. All rights reserved.
//

import UIKit
import Firebase
import PSPDFKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //License Key for configuring PSPDF
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PSPDFKitGlobal.setLicenseKey("Si/Vdkx+7JxWFP+OccLSwzYv8jR4+jUW3V/GawCR2QWK5Vv6LFy53jHQHDKXTtLCPyWoQ2r0ZMJiZCfsL8bg5C5rkiCZ6dwAVC8qQoVvDm+b/nAk/AwzHT1xL4HpY8bI9CsU4fuo5GwNT0li4IUkevaLaDGwHVetj1o5mDps50IPLllUYDBGv4H7GubpGS7JvOR9DhTM+8UI9wco5VEPS1ER0U2hXfJM5WmWMPt7wptYd2uWmXktnvumAafoR7TWYK3Ojj0UVhQMaXGBM7Hm7ILvYroC+wlNzWQ9fkcx/ZzNoea7grlmBYAAaDrY5eMuq2UUanVSNS0TmCBslcnDV8evDHtsRvwFUs9ZesVwRBQhTLRdaXYrYMqX3SMnNHG3rfMkhbO4wj2Aal6OpOqgPePg2VwzYFknUFroQXhWi5k1vnpXazqy+NyW+pY7nSiB")
        return true
    }




}

