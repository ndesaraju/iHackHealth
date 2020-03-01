//
//  ResourceListScreen.swift
//  resources
//
//  Created by Taewon Kim on 2/23/20.
//  Copyright © 2020 Taewon Kim. All rights reserved.
//

import UIKit

class ResourceListScreen: UIViewController {
    
    /**
     Tableview outlet
     */
    @IBOutlet weak var tableView: UITableView!
    
    /**
     Variables
     */
    var selection = Folder(name: "", subfolders: [], files: [], tags: ["", ""], parents: [])
    var resources: [Resource] = []
    var allFiles = [Resource]()
    var filteredFiles = [Resource]()
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resources = createArray()
        
        /**
         Search
         */
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        navigationItem.searchController = searchController
        
    }
    
    func createArray() -> [Resource] {
        
        var tempResources: [Resource] = []
        
        let resource1 = Folder(name: "Acute Pancreatitis",
                               subfolders: [
                                Folder(name: "Test",
                                       subfolders: [],
                                       files: [],
                                       tags: ["tag1","tag2"],
                                       parents: []),
                                Folder(name: "Test2",
                                       subfolders: [],
                                       files: [],
                                       tags: [],
                                       parents: [])],
                               files: [],
                               tags: ["tag", "tag2"],
                               parents: [])
        let resource2 = Folder(name: "Chronic Pancreatitis", subfolders: [
        Folder(name: "Testy",
               subfolders: [],
               files: [],
               tags: ["tag1","tag2"],
               parents: []),
        Folder(name: "Test4",
               subfolders: [],
               files: [],
               tags: [],
               parents: [])], files: [], tags: ["tAg3", "taG"], parents: [])
        
        tempResources.append(resource1)
        tempResources.append(resource2)
        
        return tempResources
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selection = resources[indexPath.row] as! Folder
        performSegue(withIdentifier: "InnerResourceSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! InnerResourceListScreen
        vc.selection = self.selection
        
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

/**
 Search functionality implemented here.
 */
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
