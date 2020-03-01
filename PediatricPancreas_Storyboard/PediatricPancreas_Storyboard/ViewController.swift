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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let storage =  Storage.storage().reference()
        let path = "test/file1.pdf"
        let downloadURL = Utils.getDownloadURL(storage: storage, path: path)
        let fileURL = Utils.getFileURL(downloadURL:downloadURL)
               
        //not working: causes program to crash
//        if let pdfDocument = PDFDocument(url: fileURL){
//            pdfView.autoScales = true
//            pdfView.displayMode = .singlePageContinuous
//            pdfView.displayDirection = .vertical
//            pdfView.document = pdfDocument
//        }

        
    }


}

