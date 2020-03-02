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
    var folderSelection = Folder(); // the folder to be selected
    var folderArray: [Resource] = []; // the array of folders to be displayed on the screen
    
    var filteredFiles = [Resource](); // not sure what you need this for, but sure
    
    var searchController: UISearchController!
    
    private var resultsTableController: ResultsTableController!
    
    /**
     Loads the view.
     */
    override func viewDidLoad() {
        super.viewDidLoad();
        folderArray = createArray();
        
        
        resultsTableController =
        self.storyboard?.instantiateViewController(withIdentifier: "ResultsTableController") as? ResultsTableController
        resultsTableController.tableView.delegate = self

        // search features
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
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
        self.folderSelection = folderArray[indexPath.row] as! Folder;
        
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
extension MainResourceView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        print(section)
        return folderArray.count;
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resource = folderArray[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCell") as! ResourceCell;
        cell.setResource(resource: resource);
        return cell;
    }
    
}

extension MainResourceView: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
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
        filteredFiles = []

        for file in File.allFiles {
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

        if let resultsController = searchController.searchResultsController as? ResultsTableController {
            resultsController.filteredFiles = filteredFiles
            resultsController.tableView.reloadData()
        }
    }
}

extension MainResourceView: UISearchControllerDelegate {

//    func presentSearchController(_ searchController: UISearchController) {
//        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
//    }
//
//    func willPresentSearchController(_ searchController: UISearchController) {
//        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
//    }
//
//    func didPresentSearchController(_ searchController: UISearchController) {
//        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
//    }
//
//    func willDismissSearchController(_ searchController: UISearchController) {
//        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
//    }
//
//    func didDismissSearchController(_ searchController: UISearchController) {
//        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
//    }

}
