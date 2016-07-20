//
//  ViewController.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/12.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    @IBOutlet weak var currentColorPreview: UIButton!

    var canvas: DrawView{
        get{
            return self.view as! DrawView
        }
    }

    var drawingColor: UIColor {
        get{
            return canvas.drawingColor
        }
        set{
            canvas.drawingColor = newValue
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentColorPreview.backgroundColor = drawingColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentColorPreview.backgroundColor = drawingColor
    }
 
    @IBAction func touchUpInside(button:UIButton){
        switch button.tag{
        case 0:
            PathManager.shared.clear()
        case 1:
            PathManager.shared.undo()
        case 2:
            PathManager.shared.redo()
        default:
            break
        }
        view.setNeedsDisplay()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let colorPickerViewController = segue.destinationViewController as? ColorPickerViewController{
            colorPickerViewController.value = drawingColor
        }
        if let rgbaViewController = segue.destinationViewController as? RGBAViewController{
            rgbaViewController.value = drawingColor
        }
    }
    
}

