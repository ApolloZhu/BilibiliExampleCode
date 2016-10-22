//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/12.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable class ColorPicker: IndicatableUIControl{

    var hue: CGFloat = 0{
        didSet{
            setNeedsDisplay()
            sendActions(for: .valueChanged)
        }
    }

    var value: UIColor{
        return UIColor(
            hue: hue,
            saturation: convert(indicator.center, to: self).y / bounds.height,
            brightness: convert(indicator.center, to: self).x / bounds.width,
            alpha: 1
        )
    }

    override func draw(_ rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()
        context?.move(to: .zero)
        let period = Int(bounds.height)
        let stops: [CGFloat] = [0.0, 1.0]

        for i in 0..<period{

            let saturation = CGFloat(i)/CGFloat(period)
            let colors = stops.map { UIColor(hue: hue, saturation: saturation, brightness: $0, alpha: 1).cgColor }
            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: stops)

            context?.saveGState()
            UIBezierPath(rect: CGRect(x: 0, y: CGFloat(i), width: bounds.width, height: 1)).addClip()
            context?.drawLinearGradient(
                gradient!,
                start: CGPoint(x: 0, y: i),
                end: CGPoint(x: bounds.maxX, y: CGFloat(i)),
                options: []
            )
            context?.restoreGState()

        }
        super.draw(rect)
    }

}
