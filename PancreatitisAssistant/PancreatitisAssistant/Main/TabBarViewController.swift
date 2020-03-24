//
//  TabBarControllerViewController.swift
//  Homescreen
//
//  Created by Niharika Desaraju on 3/1/20.
//  Copyright © 2020 ankita. All rights reserved.
//

import UIKit
import CareKit


class TabBarControllerViewController: UITabBarController {
    //fileprivate var symptomTrackerViewController: CareViewController? = nil
    
    /*
    lazy var synchronizedStoreManager: OCKSynchronizedStoreManager = {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls[0].appendingPathComponent("carePlanStore")

        if !fileManager.fileExists(atPath: url.path) {
            try! fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        let store = OCKStore(name: "iHackStore")
        let manager = OCKSynchronizedStoreManager(wrapping:store)
        return manager

    }()*/
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard   = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let home          = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        let login          = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        let care          = storyboard.instantiateViewController(withIdentifier: "CareViewController")
        let binder          = storyboard.instantiateViewController(withIdentifier: "BinderViewController")
        
        //let symptom          = storyboard.instantiateViewController(withIdentifier: "SymptomViewController")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appDelegate.synchronizedStoreManager
        let symptom = SymptomTrackerViewController(storeManager: manager)
        //symptom.tabBarItem.image = UIImage(named: "heart.fill")
        
        //navigationController?.pushViewController(self, animated: true)
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let manager = appDelegate.synchronizedStoreManager
       // let manager = synchronizedStoreManager
       // let careViewController = CareViewController(storeManager: manager)
        //self.tabBar.unselectedItemTintColor = UIColor.red
        //UITabBar.appearance().unselectedItemTintColor = UIColor.red
       /*
        let careViewController = CareViewController()
        let homeViewController = HomeViewController()
        let binderViewController = BinderViewController()
        let loginViewController = LoginViewController()
        */
        
        let controllers = [home,
                           //symptom,
                           //(symptomTrackerViewController ?? careViewController),
                            symptom,
            
                           //UINavigationController(rootViewController: careViewController),
                           binder,
                           login]
        
        viewControllers = controllers
        //viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        // Do any additional setup after loading the view.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
