//
//  DrawView.swift
//  ColorPicker
//
//  Created by Apollonian on 7/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class DrawView: UIView {

    var lines = [[Line]]()
    var trash = [[Line]]()
    var lineColor = UIColor.blackColor()
    var lastPoint = CGPoint()

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, 5)
        for line in lines{
            for segment in line{
                CGContextSetStrokeColorWithColor(context, segment.color.CGColor)
                CGContextMoveToPoint(context, segment.start.x, segment.start.y)
                CGContextAddLineToPoint(context, segment.end.x, segment.end.y)
                CGContextStrokePath(context)
            }
        }
    }

    func clear(){
        lines.removeAll()
        trash.removeAll()
        setNeedsDisplay()
    }

    func undo(){
        if !lines.isEmpty{
            trash.append(lines.removeLast())
        }
        setNeedsDisplay()
    }

    func redo(){
        if !trash.isEmpty{
            lines.append(trash.removeLast())
        }
        setNeedsDisplay()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        if !touches.isEmpty{
            lastPoint = touches.first!.locationInView(self)
            lines.append([Line]())
            setNeedsDisplay()
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        if !touches.isEmpty{
            let newPoint = touches.first!.locationInView(self)
            lines[lines.count - 1].append(Line(start: lastPoint, end: newPoint, color: lineColor))
            lastPoint = newPoint
            setNeedsDisplay()
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if !touches.isEmpty{
            let newPoint = touches.first!.locationInView(self)
            lines[lines.count - 1].append(Line(start: lastPoint, end: newPoint, color: lineColor))
            lastPoint = newPoint
            setNeedsDisplay()
        }
    }

}
