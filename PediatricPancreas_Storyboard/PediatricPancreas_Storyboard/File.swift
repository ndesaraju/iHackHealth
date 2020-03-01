//
//  Files.swift
//  database
//
//  Created by Administrator on 2/21/20.
//  Copyright © 2020 JenniferZhou. All rights reserved.
//

import Foundation

class File: Resource {
    static var allFiles: [File] = []
    
    private var _name: String
    private var _path: String
    internal var _tags: [String] = []
    //insert variables associated with files here
    
    init(name: String, path: String) {
        _name = name
        _path = path
        File.allFiles.append(self)
    }
    
    init() {
        _name = "";
        _path = "";
    }
    
    func getName() -> String {
        return _name
    }
    
    func getPath() -> String {
        return _path
    }
    
    func fetch() {
        //gets : the file somehow
    }
}

enum fileError:
Error {
    case nonexistentFile(message: String)
}
