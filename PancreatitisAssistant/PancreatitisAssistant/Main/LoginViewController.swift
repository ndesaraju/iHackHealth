//
//  LoginViewController.swift
//  PancreatitisAssistant
//
//  Created by Reet Mishra on 3/3/20.
//  Copyright © 2020 iHackHealth. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.purple
        tabBarItem.title = "Login"
        tabBarItem.image = UIImage(systemName: "person.fill")
        //SignUp.backgroundColor = UIColor.clear
        SignUp.layer.cornerRadius = 25
        SignUp.layer.borderColor = CGColor(srgbRed: 255, green: 122, blue: 145, alpha: 1)
        //navigationController?.pushViewController(self, animated: true)
        // Do any additional setup after loading the view.
    }
    
    
    
    

    
    @IBOutlet weak var SignUp: UIButton!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
