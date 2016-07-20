//
//  DrawView.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/17.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

@IBDesignable class DrawView: UIView {

    var drawingColor = UIColor.black()

    private var isCurrentLineEnded = true

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        for line in PathManager.shared.paths{
            line.color.setStroke()
            line.path.lineJoinStyle = .round
            line.path.lineCapStyle = .round
            line.path.lineWidth = 5
            line.path.stroke()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            PathManager.shared.paths.append((UIBezierPath(), drawingColor))
            isCurrentLineEnded = false
            PathManager.shared.paths.last?.path.move(to: touch.location(in: self))
        }
    }

    private func updateCurrentPath(for touches: Set<UITouch>, shouldEndPath: Bool){
        if let touch = touches.first{
            if !isCurrentLineEnded{
                PathManager.shared.paths.last?.path.addLine(to: touch.location(in: self))
                setNeedsDisplay()
            }
        }
        if shouldEndPath{
            isCurrentLineEnded = true
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateCurrentPath(for: touches, shouldEndPath: false)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateCurrentPath(for: touches, shouldEndPath: true)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateCurrentPath(for: touches, shouldEndPath: true)
    }
    
}
