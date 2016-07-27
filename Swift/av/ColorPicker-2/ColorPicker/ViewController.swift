//
//  ViewController.swift
//  ColorPicker
//
//  Created by Apollonian on 7/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var drawView: DrawView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clear() {
        drawView.clear()
    }

    @IBAction func undo() {
        drawView.undo()
    }

    @IBAction func redo() {
        drawView.redo()
    }


}

