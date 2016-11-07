//
//  ColorPickerViewController
//  ColorPicker
//
//  Created by Apollonian on 16/7/12.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {

    override var prefersStatusBarHidden: Bool{
        return true
    }

    private var hue: CGFloat = 0
    private var saturation: CGFloat = 0
    private var brightness: CGFloat = 0

    var value: UIColor{
        get{
            return colorPicker.value
        }
        set{
            newValue.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        }
    }

    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var huePicker: HuePicker!
    @IBOutlet weak var colorPicker: ColorPicker!


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        value = manager.lineColor
        huePicker.indicator?.setCenter(xTo: hue * huePicker.bounds.width)
        colorPicker.indicator?.setCenter(to: CGPoint(x: saturation * colorPicker.bounds.height, y: brightness * colorPicker.bounds.width))
        colorPicker.hue = hue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        huePicker.addTarget(self, action: #selector(ColorPickerViewController.hueValueChanged), for: .valueChanged)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        huePicker.removeTarget(self, action: #selector(ColorPickerViewController.hueValueChanged), for: .valueChanged)
        manager.lineColor = value
    }

    func hueValueChanged(){
        colorPicker.hue = huePicker.value
    }

    @IBAction func colorValueChanged() {
        preview.backgroundColor = value
    }

    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
