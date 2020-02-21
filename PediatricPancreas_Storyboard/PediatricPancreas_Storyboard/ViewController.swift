//
//  ViewController.swift
//  PediatricPancreas_Storyboard
//
//  Created by Reet Mishra on 2/19/20.
//  Copyright © 2020 Example Company. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController {
    @IBOutlet weak var imageViewer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let ref = Database.database().reference()
        let storage =  Storage.storage().reference()
        let tempImageRef = storage.child("test/img1.jpg")
        
        tempImageRef.getData(maxSize: 1*1000*1000) { (data, error) in
            if error == nil{
                print(data)
                
                self.imageViewer.image = UIImage(data: data!)
                
            }else{
                print(error?.localizedDescription)
            }
        }
        
        
    }


}

