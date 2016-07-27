//
//  Line.swift
//  ColorPicker
//
//  Created by Apollonian on 7/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class Line{
    let start, end: CGPoint
    let color: UIColor
    init(start: CGPoint, end: CGPoint, color: UIColor){
        self.start = start
        self.end = end
        self.color = color
    }
}
