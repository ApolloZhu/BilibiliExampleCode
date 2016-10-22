//
//  ViewController.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/12.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
 
    @IBAction func touchUpInside(_ button: UIButton){
        switch button.tag{
        case 0:
            manager.clear()
        case 1:
            manager.undo()
        case 2:
            manager.redo()
        default:
            break
        }
        view.setNeedsDisplay()
    }

    @IBOutlet weak var currentColorPreview: UIButton!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentColorPreview.backgroundColor = manager.lineColor
    }
}

