//
//  HuePicker.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/12.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

@IBDesignable class HuePickerLayer:CAGradientLayer{
    override init() {
        super.init()
        setup()
    }

    override init(layer: AnyObject) {
        super.init(layer: layer)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(){
        let controlPoints: [CGFloat] = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
        self.locations = controlPoints
        self.colors = controlPoints.map { return UIColor(hue: $0, saturation: 1, brightness: 1, alpha: 1).cgColor }

        self.startPoint = CGPoint(x: 0, y: 0.5)
        self.endPoint = CGPoint(x: 1, y: 0.5)
    }
}

@IBDesignable class HuePickerView: UIControl{
    var indicator = TouchIndicator()

    var value: CGFloat {
        get{
            return convert(indicator.center, to: self).x / bounds.width
        }
    }

    override class func layerClass() -> Swift.AnyClass{
        return HuePickerLayer.classForCoder()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        indicator = TouchIndicator(atCenter: center, withRadius: 10)
        addSubview(indicator)
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
        if touch != nil {
            update(for: touch!)
            sendActions(for: .touchUpInside)
        } else {
            sendActions(for: .touchCancel)
        }
    }

    private func update(for touch: UITouch){
        indicator.set(centerXTo: touch.location(in: self).fitting(in: self).x)
        sendActions(for: .valueChanged)
    }
}
