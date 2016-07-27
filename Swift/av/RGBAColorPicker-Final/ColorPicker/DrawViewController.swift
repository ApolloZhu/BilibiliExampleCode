//
//  DrawViewController.swift
//  ColorPicker
//
//  Created by Apollonian on 7/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    @IBOutlet var drawView: DrawView!
    @IBOutlet weak var preview: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preview.backgroundColor = manager.lineColor
    }

    @IBAction func touchUpInside(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            manager.clear()
        case 1:
            manager.undo()
        case 2:
            manager.redo()
        default:
            break
        }
        drawView.setNeedsDisplay()
    }



}

