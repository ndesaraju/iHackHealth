//
//  ResourceListScreen.swift
//  resources
//
//  Created by Taewon Kim on 2/23/20.
//  Copyright © 2020 Taewon Kim. All rights reserved.
//

import UIKit

class ResourceListScreen: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var resources: [Resource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resources = createArray()
        
    }
    
    func createArray() -> [Resource] {
        
        var tempResources: [Resource] = []
        
        let resource1 = Resource(labelName: "Acute Pancreatitis")
        let resource2 = Resource(labelName: "Chronic Pancreatitis")
        
        tempResources.append(resource1)
        tempResources.append(resource2)
        
        return tempResources
    }
}

extension ResourceListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resource = resources[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCell") as! ResourceCell
        
        cell.setResource(resource: resource)
        
        return cell
    }
}
