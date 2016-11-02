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
        return fitting(in: view.bounds)
    }
    func fitting(in rect: CGRect) -> CGPoint {
        let fittingX = max(min(x, rect.maxX), rect.minX)
        let fittingY = max(min(y, rect.maxY), rect.minY)
        return CGPoint(x: fittingX, y: fittingY)
    }
}

extension CGRect{
    public func intersetcs(_ point: CGPoint) -> Bool{
        return minX <= point.x && point.x <= maxX && minY <= point.y && point.y <= maxY
    }
}

enum TouchIndicatorType {
    case `default`
    case xOnly
    case yOnly
}

@IBDesignable class TouchIndicator:UIView{

    var radius: CGFloat {
        get {
            return min(bounds.width, bounds.height) / 2
        }
        set {
            frame = CGRect(x: frame.midX - newValue, y: frame.midY - newValue, width: newValue * 2, height: newValue * 2)
            layer.cornerRadius = newValue
        }
    }

    var type: TouchIndicatorType = .default

    override init(frame: CGRect) {
        if frame.size == .zero{
            super.init(frame: CGRect(origin: frame.origin, size: CGSize(width: 20, height: 20)))
        } else {
            super.init(frame: frame)
        }
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(){
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = radius
        layer.masksToBounds = true
        adjust()
    }

    func setCenter(to newCenter: CGPoint){
        setCenter(xTo: newCenter.x, yTo: newCenter.y)
    }

    func adjust(){
        if let top = superview {
            if !top.bounds.intersetcs(center) {
                setCenter(to: center.fitting(in: top))
            }
        }
    }

    func setCenter(xTo newX: CGFloat? = nil, yTo newY: CGFloat? = nil){
        if let x = newX {
            frame.origin.x = x - radius
        }
        if let y = newY {
            frame.origin.y = y - radius
        }
        adjust()
    }
}

class IndicatableUIControl: UIControl{
    let indicator = TouchIndicator()

    var defaultIndicatorType: TouchIndicatorType {
        return .default
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(indicator)
        indicator.setCenter(to: center)
        indicator.type = defaultIndicatorType
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        sendActions(for: .touchDown)
        update(for: touch)
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        update(for: touch)
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        guard touch != nil else {sendActions(for: .touchCancel);return}
        update(for: touch!)
        sendActions(for: .touchUpInside)
    }

    fileprivate func update(for touch: UITouch){
        indicator.setCenter(to: touch.location(in: self))
        sendActions(for: .valueChanged)
    }
}
