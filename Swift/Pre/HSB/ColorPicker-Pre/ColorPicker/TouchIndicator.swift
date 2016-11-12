//
//  TouchIndicator.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/17.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

extension CGPoint {
    func fitting(in view: UIView) -> CGPoint {
        return fitting(in: view.bounds)
    }
    func fitting(in rect: CGRect) -> CGPoint {
        let fittingX = max(min(x, rect.maxX), rect.minX)
        let fittingY = max(min(y, rect.maxY), rect.minY)
        return CGPoint(x: fittingX, y: fittingY)
    }
}

extension CGRect {
    public func intersetcs(_ point: CGPoint) -> Bool {
        return (minX...maxX).contains(point.x) && (minY...maxY).contains(point.y)
    }
}

enum TouchIndicatorType {
    case `default`
    case xOnly
    case yOnly
}

@IBDesignable class TouchIndicator: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        radius = radius <= 0 ? 10 : radius
    }

    var radius: CGFloat {
        get {
            return min(bounds.width, bounds.height) / 2
        }
        set {
            let newRadius = abs(newValue)
            bounds = CGRect(
                x: bounds.midX - newRadius,
                y: bounds.midY - newRadius,
                width: newRadius * 2,
                height: newRadius * 2
            )
            layer.cornerRadius = newRadius
            adjust()
        }
    }

    func adjust() {
        if let isFittingInSuperview = isFittingInSuperview, !isFittingInSuperview {
            setCenterTo(center.fitting(in: superview!))
        }
    }

    var isFittingInSuperview : Bool? {
        if let top = superview {
            return top.bounds.intersetcs(center)
        }
        return nil
    }

    func setCenterTo(_ newCenter: CGPoint) {
        setCenterTo(x: newCenter.x, y: newCenter.y)
    }

    func setCenterTo(x newX: CGFloat? = nil, y newY: CGFloat? = nil) {
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
    var indicator = TouchIndicator()

    var type: TouchIndicatorType { return .default }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(indicator)
        indicator.setCenterTo(x: bounds.midX, y: bounds.midY)
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
        let location = touch.location(in: self)
        switch type {
        case .xOnly:
            indicator.setCenterTo(x: location.x)
        case .yOnly:
            indicator.setCenterTo(y: location.y)
        default:
            indicator.setCenterTo(location)
        }
        sendActions(for: .valueChanged)
    }
}
