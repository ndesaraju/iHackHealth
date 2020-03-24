//
//  HomeViewController.swift
//  PancreatitisAssistant
//
//  Created by Reet Mishra on 3/3/20.
//  Copyright © 2020 iHackHealth. All rights reserved.
//

import UIKit
import CareKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red:1.00, green:0.48, blue:0.57, alpha:1.0)
        tabBarItem.title = "Home"
        tabBarItem.image = UIImage(systemName: "house.fill")
        //navigationController?.pushViewController(self, animated: true)
    }
    
    /*
    @objc func MenuActions(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 0 {
            tabBarController?.selectedIndex = 2
        }
        
    }*/
    /*
    @IBAction func Care(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appDelegate.synchronizedStoreManager
        let careViewController = SymptomTrackerViewController(storeManager: manager)
        present(careViewController, animated: false)
    }
    */


    
}

