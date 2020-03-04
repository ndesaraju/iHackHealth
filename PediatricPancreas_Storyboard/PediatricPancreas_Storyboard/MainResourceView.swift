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
    var fileSelection = File();
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
        definesPresentationContext = true
        
    }
    
    /**
     Creates the array of folders that will be displayed.
     */
    func createArray() -> [Resource] {
        
        var tempResources: [Resource] = []; // a temporary array
        
        // test folders
        let res1 = Folder(name: "About Us", subfolders: [], files: [
            File(name: "Refer a patient.pdf", path: "Refer a patient.pdf")
        ], tags: ["tag", "tag2"], parents: []);
        let res2 = Folder(name: "Congenital Hyperinsulinism", subfolders: [], files: [
            File(name: "Hyperinsulinism info sheet.pdf", path: "Hyperinsulinism info sheet.pdf")
        ], tags: ["tAg3", "taG"], parents: []);
        let res3 = Folder(name: "Diabetes", subfolders: [], files: [
        ], tags: [], parents: []);
        let res4 = Folder(name: "Helpful Contacts", subfolders: [], files: [
            File(name: "Helpful Numbers.pdf", path: "Helpful Numbers.pdf")
        ], tags: [], parents: []);
        let res5 = Folder(name: "Lab Tests", subfolders: [], files: [
            File(name: "Oral Glucose Tolerance Test (OGTT).pdf", path: "Testing/Oral Glucose Tolerance Test (OGTT).pdf"),
            File(name: "Pancreatitis Genetic testing.pdf", path: "Testing/Pancreatitis Genetic testing.pdf"),
            File(name: "Stool pancreatic elastase.pdf", path: "Testing/Stool pancreatic elastase.pdf"),
            File(name: "Sweat chloride test.pdf", path: "Testing/Sweat chloride test.pdf")
        ], tags: [], parents: []);
        let res6 = Folder(name: "Pancreatitis", subfolders: [], files: [
            File(name: "Acute Pancreatitis.pdf", path: "Acute Pancreatitis.pdf"),
            File(name: "Chronic pancreatitis.pdf", path: "Chronic pancreatitis.pdf"),
            File(name: "EPI info sheet.pdf", path: "EPI info sheet.pdf"),
            File(name: "Online resources handout .pdf", path: "Online resources handout .pdf"),
            File(name: "Pain management and pancreatitis.pdf", path: "Pain management and pancreatitis.pdf"),
            File(name: "Pancreas divisum handout.pdf", path: "Pancreas divisum handout.pdf"),
            File(name: "Pancreatic Enzyme Medication.pdf", path: "Pancreatic Enzyme Medication.pdf"),
            File(name: "Pancreatitis and Nutrition.pdf", path: "Pancreatitis and Nutrition.pdf"),
            File(name: "Pancreatitis monitoring.pdf", path: "Pancreatitis monitoring.pdf")
        ], tags: [], parents: []);
        let res7 = Folder(name: "Procedures", subfolders: [], files: [
            File(name: "Colonoscopy.pdf", path: "Colonoscopy.pdf"),
            File(name: "EGD info sheet.pdf", path: "EGD info sheet.pdf"),
            File(name: "ERCP info sheet.pdf", path: "ERCP info sheet.pdf"),
            File(name: "Gastric Emptying Study.pdf", path: "Gastric Emptying Study.pdf"),
            File(name: "MRCP info sheet.pdf", path: "MRCP info sheet.pdf"),
            File(name: "MRE info sheet.pdf", path: "MRE info sheet.pdf"),
            File(name: "Upper GI.pdf", path: "Upper GI.pdf")
        ], tags: [], parents: []);
        let res8 = Folder(name: "School", subfolders: [], files: [
            ], tags: [], parents: []);
        let res9 = Folder(name: "TPIAT", subfolders: [], files: [
            File(name: "Pediatric TPIAT Brief overview.pdf", path: "Pediatric TPIAT Brief overview.pdf"),
            File(name: "TPIAT eval checklist.pdf", path: "TPIAT eval checklist.pdf")
        ], tags: [], parents: []);
        
        tempResources.append(res1)
        tempResources.append(res2)
        tempResources.append(res3)
        tempResources.append(res4)
        tempResources.append(res5)
        tempResources.append(res6)
        tempResources.append(res7)
        tempResources.append(res8)
        tempResources.append(res9)
        
        return tempResources
        
    }
    
    /**
     A method that will be run once the user selects a row (a folder).
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // implement select/deselect animation
        tableView.deselectRow(at: indexPath, animated: true);
        
        // Check to see which table view cell was selected.
        if tableView === self.tableView {
            // the folder that was selected
            self.folderSelection = folderArray[indexPath.row] as! Folder;
            performSegue(withIdentifier: "InnerResourceSegue", sender: self);
        } else {
            
//            resultsTableController.tableView(self.tableView, didSelectRowAt: indexPath)
//
            resultsTableController.fileSelection = resultsTableController.filteredFiles[indexPath.row] as! File;

            resultsTableController.performSegue(withIdentifier: "searchSegue", sender: self);
        }
    }
    
    /**
     This method is called right before performing a segue, passing along information from the current view.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "InnerResourceSegue" {
            let vc = segue.destination as! InnerResourceView;
            vc.folderSelection = self.folderSelection;
        } else {
            let vc = segue.destination as! PDFViewController;
            vc.fileSelection = self.fileSelection;
        }
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
        let count = filterFiles(for: searchController.searchBar.text ?? "")

        if let resultsController = searchController.searchResultsController as? ResultsTableController {
            resultsController.filteredFiles = filteredFiles
            resultsController.tableView.reloadData()
        }
        
//        resultsTableController.resultsLabel.text = resultsTableController.filteredFiles.isEmpty ?
//        NSLocalizedString("NoItemsFoundTitle", comment: "") :
//        String(format: NSLocalizedString("Items found: %ld", comment: ""),
//               resultsTableController.filteredFiles.count)
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
