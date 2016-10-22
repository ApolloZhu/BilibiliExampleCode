//
//  DrawView.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/17.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

@IBDesignable class DrawView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        for line in manager.lines{
            line.color.setStroke()
            line.path.lineJoinStyle = .round
            line.path.lineCapStyle = .round
            line.path.lineWidth = 5
            line.path.stroke()
        }
    }

    fileprivate func update(for touches: Set<UITouch>){
        if let location = touches.first?.location(in: self){
            manager.currentLine?.path.addLine(to: location)
        }
        setNeedsDisplay()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self){
            manager.addLine()
            manager.currentLine?.path.move(to: location)
            setNeedsDisplay()
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        update(for: touches)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        update(for: touches)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        update(for: touches)
    }
    
}
