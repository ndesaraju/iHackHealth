//
//  PDFViewController.swift
//  PediatricPancreas_Storyboard
//
//  Created by Reet Mishra on 2/19/20.
//  Copyright © 2020 Example Company. All rights reserved.
//

import UIKit
import Firebase
import PDFKit

class PDFViewController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView!
    
    // Information from previous view controller.
    // Please find a way to display this file.
    var fileSelection = File(name: "", path: "");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileNames : [String] = ["Oral Glucose Tolerance Test", "Pancreatitis Genetic Testing", "Stool Prancreatic Elastase", "Sweat Chloride Test"]
        
        let filePaths : [String] = ["Testing/Oral Glucose Tolerance Test (OGTT).pdf", "Testing/Pancreatitis Genetic testing.pdf", "Stool pancreatic elastase.pdf", "Sweat chloride test.pdf"]
        
        for index in 0..<fileNames.count {
            File.init(name: fileNames[index], path: filePaths[index])
        }
        
        let storage = Storage.storage().reference()
        let path = File.allFiles[0].getPath()
        print(storage.bucket)
        let file = storage.child(path)
        file.downloadURL{ url, error in
            if let error = error{
                print(error.localizedDescription)
            } else {
                if let downloadURL = url{
                    Utils.loadFileAsync(url: downloadURL) { (path, error) in
                        print("PDF File downloaded to : \(path!)")
                        let fileUrl = URL.init(fileURLWithPath:path!)
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

