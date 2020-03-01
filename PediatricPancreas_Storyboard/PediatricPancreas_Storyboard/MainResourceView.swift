//
//  MainResourceView.swift
//  PediatricPancreas_Storyboard
//
//  Created by Taewon Kim on 2/23/20.
//  Copyright © 2020 Taewon Kim. All rights reserved.
//

import UIKit

class MainResourceView: UIViewController {
    
    /**
     Outlet
     */
    @IBOutlet weak var tableView: UITableView!
    
    /**
     Variables
     */
    var folderSelection = Folder(name: "", subfolders: [], files: [], tags: ["", ""], parents: []); // the folder to be selected
    var resources: [Resource] = []; // the array of folders to be displayed on the screen
    
    var allFiles = [Resource](); // not sure what you need this for, but sure
    var filteredFiles = [Resource](); // not sure what you need this for, but sure
    
    var searchController: UISearchController!;
    
    /**
     Loads the view.
     */
    override func viewDidLoad() {
        super.viewDidLoad();
        resources = createArray();
        
        // search features
        searchController = UISearchController(searchResultsController: nil);
        searchController.searchResultsUpdater = self;
        searchController.obscuresBackgroundDuringPresentation = false;
        searchController.definesPresentationContext = true;
        
        navigationItem.searchController = searchController;
        
    }
    
    /**
     Creates the array of folders that will be displayed.
     */
    func createArray() -> [Resource] {
        
        var tempResources: [Resource] = []; // a temporary array
        
        // test folders
        let testRes1 = Folder(name: "Acute Pancreatitis",
                               subfolders: [],
                               files: [File(name: "Test.pdf", path: "")],
                               tags: ["tag", "tag2"],
                               parents: []);
        let testRes2 = Folder(name: "Chronic Pancreatitis",
                               subfolders: [],
                               files: [File(name: "Test2.pdf", path: "")],
                               tags: ["tAg3", "taG"],
                               parents: []);
        
        tempResources.append(testRes1)
        tempResources.append(testRes2)
        
        return tempResources
        
    }
    
    /**
     A method that will be run once the user selects a row (a folder).
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // implement select/deselect animation
        tableView.deselectRow(at: indexPath, animated: true);
        
        // the folder that was selected
        folderSelection = resources[indexPath.row] as! Folder;
        
        // performs a segue to the next view
        performSegue(withIdentifier: "InnerResourceSegue", sender: self);
        
    }
    
    /**
     This method is called right before performing a segue, passing along information from the current view.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // cast the segue destination
        let vc = segue.destination as! InnerResourceView;
        
        // passes the current folder selection to the next view
        vc.folderSelection = self.folderSelection;
        
    }
    
}

/**
DIsplays the current folders for this view.
*/
extension MainResourceView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resource = resources[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCell") as! ResourceCell;
        cell.setResource(resource: resource);
        return cell;
    }
    
}

/**
 Search functionality should be implemented here.
 */
extension MainResourceView: UISearchResultsUpdating {
    
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
        filterFiles(for: searchController.searchBar.text ?? "") // Fix this
    }
    
    
}
