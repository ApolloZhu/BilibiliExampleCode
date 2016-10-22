//
//  PathManager.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/17.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

typealias Line = (path: UIBezierPath, color: UIColor)
let manager = PathManager.shared

class PathManager{
    static let shared = PathManager()
    fileprivate init(){}

    var lines = [Line]()
    var trash = [Line]()
    var lineColor = UIColor.black

    var currentLine: Line?{
        return lines.last
    }

    func addLine(){
        lines.append((UIBezierPath(), lineColor))
    }

    func clear(){
        lines.removeAll()
        trash.removeAll()
    }

    func undo(){
        if !lines.isEmpty{
            trash.append(lines.removeLast())
        }
    }

    func redo(){
        if !trash.isEmpty{
            lines.append(trash.removeLast())
        }
    }
}

