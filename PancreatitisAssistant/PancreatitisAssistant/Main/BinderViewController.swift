//
//  BinderViewController.swift
//  PancreatitisAssistant
//
//  Created by Reet Mishra on 3/3/20.
//  Copyright © 2020 iHackHealth. All rights reserved.
//

import UIKit

class BinderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:1.00, green:0.48, blue:0.57, alpha:1.0)
        tabBarItem.title = "Browse"
        tabBarItem.image = UIImage(systemName: "folder.fill")
        //navigationController?.pushViewController(self, animated: true)
        // Do any additional setup after loading the view.
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    

}
