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

    override init(layer: Any) {
        super.init(layer: layer)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(){
        var stops = [Double]()
        stops.append(contentsOf: stride(from: 0, through: 1, by: 0.1))
        self.locations = stops as [NSNumber]?
        self.colors = stops.map { UIColor(hue: CGFloat($0), saturation: 1, brightness: 1, alpha: 1).cgColor }

        self.startPoint = CGPoint(x: 0, y: 0.5)
        self.endPoint = CGPoint(x: 1, y: 0.5)
    }
}

@IBDesignable class HuePicker: IndicatableUIControl{
    var value: CGFloat {
        return convert(indicator.center, to: self).x / bounds.width
    }

    override open class var layerClass: Swift.AnyClass {
        return HuePickerLayer.self
    }
    override var type: TouchIndicatorType {
        return .xOnly
    }
}
