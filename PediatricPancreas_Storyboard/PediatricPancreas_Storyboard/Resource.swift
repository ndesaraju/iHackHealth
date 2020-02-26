//
//  Resource.swift
//  database
//
//  Created by Administrator on 2/23/20.
//  Copyright © 2020 JenniferZhou. All rights reserved.
//

import Foundation

protocol Resource {
    var _tags: [String] { get }
    
    /** Returns index of specified tag, or -1 if tag does not exist. */
    func hasTag(tag: String) -> Int
    /** Returns the name of the file or folder. */
    func getName() -> String
    /** Returns a list of all the tags of the file or folder */
    func getTags() -> [String]
}

extension Resource {
    
    func hasTag(tag: String) -> Int {
        for index in 0..<self._tags.count {
            if self._tags[index] == tag {
                return index
            }
        }
        return -1
    }
    
    func getTags() -> [String] {
        return _tags
    }
}
