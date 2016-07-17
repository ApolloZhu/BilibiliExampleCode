//
//  TouchIndicator.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/17.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

extension CGPoint{
    func fitting(in view: UIView) -> CGPoint{
        let bounds = view.bounds
        let fittingX = max(min(x, bounds.maxX), bounds.minX)
        let fittingY = max(min(y, bounds.maxY), bounds.minY)
        return CGPoint(x: fittingX, y: fittingY)
    }
}

@IBDesignable class TouchIndicator:UIView{

    var radius: CGFloat{
        return min(bounds.width, bounds.height) / 2
    }

    init(atCenter midPoint: CGPoint = .zero, withRadius r: CGFloat = 10) {
        super.init(frame: CGRect(x: midPoint.x, y: midPoint.y, width: r * 2, height: r * 2))
        setup()
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(){
        self.backgroundColor = .white()
        self.layer.borderColor = UIColor.black().cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func set(centerTo newValue: CGPoint){
        self.frame = CGRect(x: newValue.x - radius, y: newValue.y - radius, width: frame.width, height: frame.height)
    }

    func set(centerXTo newValue: CGFloat){
        self.frame = CGRect(x: newValue - radius, y: frame.minY, width: frame.width, height: frame.height)
    }

    func set(centerYTo newValue: CGFloat){
        self.frame = CGRect(x: frame.minX, y: newValue - radius, width: frame.width, height: frame.height)
    }

    func set(radiusTo newValue: CGFloat){
        self.frame = CGRect(x: frame.midX - newValue, y: frame.midY - newValue, width: newValue * 2, height: newValue * 2)
        layer.cornerRadius = newValue
    }
    
}
