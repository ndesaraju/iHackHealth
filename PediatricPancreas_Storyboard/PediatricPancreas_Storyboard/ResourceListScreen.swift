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
    var allFiles = [Resource]()
    var filteredFiles = [Resource]()
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resources = createArray()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        navigationItem.searchController = searchController
        
    }
    
    func createArray() -> [Resource] {
        
        var tempResources: [Resource] = []
        
        let resource1 = Folder("Acute Pancreatitis", [], [], ["tag", "tag2"], [])
        let resource2 = Folder("Chronic Pancreatitis", [], [], ["tAg3", "taG"], [])
        
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

extension ResourceListScreen: UISearchResultsUpdating {
    
    /** Sets filteredList to be the files matching SEARCHTEXT and returns the number of valid files */
    private func filterFiles(for searchText: String) -> Int {
        let lower = searchText.lowercased()
        var count = 0
        
        for file in allFiles {
            if file.getName().lowercased().contains(lower) {
                filteredFiles.append(file)
                count += 1
            } else {
                for tag in file.getTags() {
                    if tag.lowercased().contains(lower) {
                        filteredFiles.append(file)
                        count += 1
                        break
                    }
                }
            }
        }
        return count
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterFiles(for: searchController.searchBar.text ?? "")
    }
    
    
}
