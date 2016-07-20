//
//  PathManager.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/17.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import Foundation
import UIKit

class PathManager{

    static let shared = PathManager()

    private init(){}

    var paths = [(path: UIBezierPath, color: UIColor)]()
    private var trash = [(UIBezierPath, UIColor)]()

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
