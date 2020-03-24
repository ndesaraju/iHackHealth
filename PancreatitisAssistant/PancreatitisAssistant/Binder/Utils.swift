//
//  Utils.swift
//  PediatricPancreas_Storyboard
//
//  Created by Jeffery Cheng on 2/29/20.
//  Copyright © 2020 Example Company. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase

class Utils{

    /* get downloada URL from firebase, runs asynchronously so doesn't work */
    static func getDownloadURL(storage : StorageReference, path : String) -> URL{
        let file = storage.child(path)
        
        var destination : [String] = []
        
        file.downloadURL{ url, error in
            print(error)
            print(url)
            destination.append(url!.absoluteString)
            return
        }
        let url = URL.init(fileURLWithPath: destination[0])
        return url
    }
    /* download files synchronously */
    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void){
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }

    /*download files asynchronously*/
    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void){
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
       
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl.path, error)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
    
/*runs asynchronously in Firebase functions so it doesn't work*/
    static func getFileURL(downloadURL : URL) -> URL {
        var fileURL : [String] = []
        loadFileAsync(url: downloadURL) { (path, error) in
            print("PDF File downloaded to : \(path!)")
            fileURL.append(path!)
        }
        let url = URL.init(fileURLWithPath: fileURL[0])
        return url
    }
    
    
}
