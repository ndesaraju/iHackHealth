//
//  InnerResourceListScreen.swift
//  PediatricPancreas_Storyboard
//
//  Created by Taewon Kim on 3/1/20.
//  Copyright © 2020 Taewon Kim. All rights reserved.
//

import UIKit

class InnerResourceView: UIViewController {
    
    /**
     Outlets
     */
    @IBOutlet weak var tableView: UITableView!
    
    /**
     Variables
     */
    var folderSelection = Folder(name: "", subfolders: [], files: [], tags: ["", ""], parents: []); // the current selected folder
    var fileSelection = File(name: "", path: ""); // the file to be selected
    var resources: [Resource] = []; // the array of files to be displayed on the screen
    
    var allFiles = [Resource]()
    var filteredFiles = [Resource]()
    
    var searchController: UISearchController!
    
    /**
     Loads the view.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        resources = folderSelection.getFiles()
        
        // search features
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        navigationItem.searchController = searchController
        
    }
    
    /**
     A method that will be run once the user selects a row (a file).
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // implement select/deselect animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        // the file that was selected
        self.fileSelection = resources[indexPath.row] as! File
        
        // performs a segue to the next view
        performSegue(withIdentifier: "PDFViewResourceSegue", sender: self)
        
    }
    
    /**
     This method is called right before performing a segue, passing along information from the current view.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // cast the segue destination
        let vc = segue.destination as! PDFViewController
        
        // pass the current file selection to the next view
        vc.fileSelection = self.fileSelection
    }
    
}

/**
DIsplays the current files for this view.
*/
extension InnerResourceView: UITableViewDataSource, UITableViewDelegate {
    
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
 Search functionality should be implemented here.
 */
extension InnerResourceView: UISearchResultsUpdating {
    
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
