//
//  ColorPickerViewController
//  ColorPicker
//
//  Created by Apollonian on 16/7/12.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {

    private var hue: CGFloat = 0
    private var saturation: CGFloat = 0
    private var brightness: CGFloat = 0

    var value: UIColor{
        get{
            return colorPickerView.value
        }
        set{
            newValue.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        }
    }

    @IBOutlet weak var preview: UIView!
    @IBOutlet private weak var colorPickerView: ColorPickerView!
    @IBOutlet private weak var huePickerView: HuePickerView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        huePickerView.indicator.set(centerXTo: hue * huePickerView.bounds.width)
        colorPickerView.indicator.set(centerTo: CGPoint(x: saturation * colorPickerView.bounds.height, y: brightness * colorPickerView.bounds.width))
        colorPickerView.hue = hue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        huePickerView.addTarget(self, action: #selector(ColorPickerViewController.hueValueChanged), for: .valueChanged)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        huePickerView.removeTarget(self, action: #selector(ColorPickerViewController.hueValueChanged), for: .valueChanged)
    }
    
    func hueValueChanged(){
        colorPickerView.hue = huePickerView.value
    }

    @IBAction func colorValueChanged() {
        preview.backgroundColor = value
    }

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let drawViewController = segue.destinationViewController as? DrawViewController{
            drawViewController.drawingColor = value
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
