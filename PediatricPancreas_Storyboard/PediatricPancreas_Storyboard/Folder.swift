//
//  main.swift
//  database
//
//  Created by jenny B) on 2/20/20.
//  Copyright © 2020 JenniferZhou. All rights reserved.

import Foundation

class Folder: Resource {
    static var allFolders: [Folder] = []
    
    private var _name: String
    private var _prev: Folder?
    private var _subfolders: [Folder] = []
    private var _files: [File] = []
    internal var _tags: [String] = [] //listed in order of importance
    
    /** Initializes a folder with name, list of subfolders, and tags.
        Add this folder to the list of all folders.
        Places self in the subfolders of other folders if needed. */
    init(name: String, subfolders: [Folder], files: [File], tags: [String],
         parents: [String]) {
        self._name = name
        self._subfolders = subfolders
        self._tags = tags
        self._files = files
        
        Folder.allFolders.append(self)
        
        for parent in parents {
            for folder in Folder.allFolders {
                if parent == folder.getName() {
                    folder.addChild(child: self)
                }
            }
        }
    }
    
    /** Returns the name of the folder. */
    func getName() -> String {
        return self._name
    }
    
//    /** Returns index of specified tag, or -1 if tag does not exist. */
//    func hasTag(tag: String) -> Int {
//        for index in 0..<self._tags.count {
//            if self._tags[index] == tag {
//                return index
//            }
//        }
//        return -1
//    }
    
    /** Sets previous folder. */
    func setPrev(previous: Folder) {
        self._prev = previous
    }
    
    /** Returns previous folder, if one exists. Otherwise, throws folderError. */
    func getPrev() throws -> Folder {
        if _prev != nil {
            return self._prev!
        }
        else {
            throw folderError.nonexistentFolder(message: "There is no prevous folder. Stop.")
        }
    }
    
    /** Adds a folder to list of subfolders.  */
    func addChild(child: Folder) {
        self._subfolders.append(child)
    }
    
    /** Removes specified folder from subfolders; returns 1 if successful, 0 if child was not found. */
    func removeChild(child: Folder) -> Int {
        for index in 0..<self._subfolders.count {
            if self._subfolders[index] === child {
                self._subfolders.remove(at: index)
                return 1
            }
        }
        return 0
    }
    
    /** Returns the subfolder that has the specified folderName.
        If folder cannot be found, throws folderError. */
    func getFolder(folderName: String) throws -> Folder {
        for folder in self._subfolders {
            if folder.getName() == folderName {
                folder.setPrev(previous: self)
                return folder
            }
        }
        throw folderError.nonexistentFolder(message: "There is no subfolder with this name. Stop.")
    }
    
    /**
     Returns all subfolders of this folder.
     */
    func getSubfolders() -> [Folder] {
        return self._subfolders
    }
    
    
    /**
     Adds a file FILE to this folder.
     */
    func addFile(file: File) {
        _files.append(file)
    }
    
    /**
     Returns a file with FILENAME that is within this folder.
     */
    func getFile(fileName: String) throws -> File {
        for file in _files {
            if file.getName() == fileName {
                return file
            }
        }
        throw fileError.nonexistentFile(message: "No such file exists. Stop.")
    }
    
    /**
     Returns all files within a folder.
     */
    func getFiles() -> [File] {
        return self._files
    }
    
}

enum folderError:
Error {
    case nonexistentFolder(message: String)
}
