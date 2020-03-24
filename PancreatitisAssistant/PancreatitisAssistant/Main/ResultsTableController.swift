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
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let nib = UINib(nibName: "TableCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
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
}
