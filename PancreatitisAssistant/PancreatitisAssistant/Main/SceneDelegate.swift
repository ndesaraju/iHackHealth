//
//  SceneDelegate.swift
//  PancreatitisAssistant
//
//  Created by Reet Mishra on 3/3/20.
//  Copyright © 2020 iHackHealth. All rights reserved.
//

import UIKit
import CareKit
import ResearchKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appDelegate.synchronizedStoreManager
        
        let symptomTrackerViewController = UINavigationController(rootViewController: SymptomTrackerViewController(storeManager: manager))
        /*
        let contentView = SymptomTrackerViewController(storeManager: manager)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = contentView
            self.window = window
            window.makeKeyAndVisible()
        }
*/
        /*
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = symptomTrackerViewController
            window?.tintColor = UIColor { $0.userInterfaceStyle == .light ? #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) : #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)}
            window?.makeKeyAndVisible()
        }*/
        
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let manager = appDelegate.synchronizedStoreManager
        //let careViewController = UINavigationController(rootViewController: CareViewController(storeManager: manager))
        //let tabViewController = TabBarView
        

        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
        //    window?.rootViewController = 
            window?.tintColor = UIColor { $0.userInterfaceStyle == .light ? #colorLiteral(red: 0.9960784314, green: 0.3725490196, blue: 0.368627451, alpha: 1) : #colorLiteral(red: 0.8627432641, green: 0.2630574384, blue: 0.2592858295, alpha: 1) }
            window?.makeKeyAndVisible()
        }*/
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appDelegate.synchronizedStoreManager

        
        let careViewController = UINavigationController(rootViewController: CareViewController(storeManager: manager))

        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = careViewController
            window?.tintColor = UIColor { $0.userInterfaceStyle == .light ? #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1) : #colorLiteral(red: 1, green: 0.4364351034, blue: 0.5621480346, alpha: 1)
            }
            window?.makeKeyAndVisible()
        }*/
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

