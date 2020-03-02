//
//  PDFViewController.swift
//  PediatricPancreas_Storyboard
//
//  Created by Reet Mishra on 2/19/20.
//  Copyright © 2020 Example Company. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import PDFKit

class PDFViewController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView!
    
    // Information from previous view controller.
    // Please find a way to display this file.
    var fileSelection = File();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //declare storage refence
        let storage = Storage.storage().reference()
        //getting file path on firebase
        let path = fileSelection.getPath();
        //getting file on firebase
        let file = storage.child(path)
        
        //getting download URL of pdf
        file.downloadURL{ url, error in
            
            if let error = error{
                
                print(error.localizedDescription)
            
            } else {
                
                if let downloadURL = url{
                    //download pdf through downloader in Utils
                    Utils.loadFileAsync(url: downloadURL) { (path, error) in
                        
                        print("PDF File downloaded to : \(path!)")
                        
                        //getting url with local file path
                        let fileUrl = URL.init(fileURLWithPath:path!)
                        
                        //initializing pdfView
                        if let pdfDocument = PDFDocument(url: fileUrl) {
                            self.pdfView.autoScales = true
                            self.pdfView.displayMode = .singlePageContinuous
                            self.pdfView.displayDirection = .vertical
                            self.pdfView.document = pdfDocument
                        }
                    }
                } else {
                    print("error")
                }
            }
        }
    }
}

