import UIKit

@IBDesignable
class HueGradientLayer: CAGradientLayer {
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
    private func setup() {
        var controls = [CGFloat]()
//        controls = [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]
        controls = Array(stride(from: 0, through: 1, by: 0.1))
        locations = controls as [NSNumber]?
//        colors = controls.map({ (hue) -> CGColor in
//            UIColor(hue: CGFloat(hue), saturation: 1, brightness: 1, alpha: 1).cgColor
//        })
        colors = controls.map { UIColor(hue: $0, saturation: 1, brightness: 1, alpha: 1).cgColor }
        startPoint = CGPoint(x: 0, y: 0.5)
        endPoint = CGPoint(x: 1, y: 0.5)
    }
}

class HueGradientView: UIView {
    override open class var layerClass: AnyClass {
        return HueGradientLayer.self
    }
}

//let view = HueGradientView(frame: CGRect(x:0,y:0,width:100,height:100))

let view = HueGradientView(frame: CGRect(x:0,y:0,width:685,height:30))



