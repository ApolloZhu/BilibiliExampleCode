//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/12.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable class ColorPickerView: UIControl{
    let indicator = TouchIndicator(withRadius: 10)

    private var period: Int{
        return Int(min(bounds.width, bounds.height))
    }

    var hue: CGFloat = 0{
        didSet{
            setNeedsDisplay()
            sendActions(for: .valueChanged)
        }
    }

    var value: UIColor{
        get{
            return UIColor(
                hue: hue,
                saturation: convert(indicator.center, to: self).y / bounds.height,
                brightness: convert(indicator.center, to: self).x / bounds.width,
                alpha: 1
            )
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        indicator.set(centerTo: center)
        addSubview(indicator)
    }

    final let locations: [CGFloat] = [0.0, 1.0]

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()
        context?.moveTo(x: 0, y: 0)

        for i in 0..<period{

            let saturation = CGFloat(i)/CGFloat(period)
            let colors = locations.map { UIColor(hue: hue, saturation: saturation, brightness: $0, alpha: 1).cgColor }

            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceCMYK(), colors: colors, locations: locations)

            context?.saveGState()

            let y = bounds.height * saturation
            UIBezierPath(rect: CGRect(x: 0, y: y, width: bounds.width, height: 1)).addClip()

            context?.drawLinearGradient(
                gradient!,
                start: CGPoint(x: 0, y: y),
                end: CGPoint(x: bounds.maxX, y: y),
                options: []
            )

            context?.restoreGState()

        }
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
        guard touch != nil else {return}
        update(for: touch!)
        sendActions(for: .touchUpInside)
    }

    private func update(for touch: UITouch){
        indicator.set(centerTo: touch.location(in: self).fitting(in: self))
        sendActions(for: .valueChanged)
    }
}
