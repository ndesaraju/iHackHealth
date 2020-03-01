//
//  InnerResourceListScreen.swift
//  PediatricPancreas_Storyboard
//
//  Created by Taewon Kim on 3/1/20.
//  Copyright © 2020 Example Company. All rights reserved.
//

import UIKit

class InnerResourceListScreen: UIViewController {
    
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
        resources = selection.getSubfolders()
        
        // Search feature.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        navigationItem.searchController = searchController
        
    }
    
//    func createArray() -> [Resource] {
//        
//        var tempResources: [Resource] = []
//        
//        
//        let resource1 = Folder(name: "What to do", subfolders: [], files: [], tags: ["Tag1", "Tag4"], parents: [])
//        let resource2 = Folder(name: "How to do", subfolders: [], files: [], tags: ["Tag2", "Tag3"], parents: [])
//        
//        tempResources.append(resource1)
//        tempResources.append(resource2)
//        
//        return tempResources
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "PDFViewResourceSegue", sender: self)
    }
    
}

extension InnerResourceListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resource = resources[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "InnerResourceCell") as! ResourceCell
        
        cell.setResource(resource: resource)
        
        return cell
    }
}

/**
 Search Functionality
 */
extension InnerResourceListScreen: UISearchResultsUpdating {
    
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
