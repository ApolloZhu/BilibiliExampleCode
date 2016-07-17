//
//  PathManager.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/17.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import Foundation

class PathManager{

    static let shared = PathManager()

    var paths = [Path]()
    private var trash = [Path]()

    func undo(){
        if !paths.isEmpty{
            trash.append(paths.removeLast())
        }
    }

    func redo(){
        if !trash.isEmpty{
            paths.append(trash.removeLast())
        }
    }

    func clear(){
        paths.removeAll()
        trash.removeAll()
    }

}
