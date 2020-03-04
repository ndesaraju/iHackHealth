//
//  ResultsTableController.swift
//  PediatricPancreas_Storyboard
//
//  Created by Administrator on 3/1/20.
//  Copyright © 2020 Example Company. All rights reserved.
//

import UIKit

class ResultsTableController: UITableViewController {
    
    let tableViewCellIdentifier = "cellID"
    
    var filteredFiles = [Resource]()
    
    var fileSelection = File();
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFiles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        let file = filteredFiles[indexPath.row]
        
        cell.textLabel?.text = file.getName()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        self.fileSelection = filteredFiles[indexPath.row] as! File;
        performSegue(withIdentifier: "searchSegue", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PDFViewController;
        
        vc.fileSelection = self.fileSelection;
    }
    
    
}
