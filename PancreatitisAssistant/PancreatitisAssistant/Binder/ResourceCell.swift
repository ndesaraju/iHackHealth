//
//  ResourceCell.swift
//  resources
//
//  Created by Taewon Kim on 2/23/20.
//  Copyright © 2020 Taewon Kim. All rights reserved.
//

import UIKit

class ResourceCell: UITableViewCell {

    @IBOutlet weak var resourceName: UILabel!
    
    func setResource(resource: Resource) {
        resourceName.text = resource.getName()
    }
    
}
