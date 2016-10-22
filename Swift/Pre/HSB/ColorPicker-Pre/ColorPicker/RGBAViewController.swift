//
//  RGBAViewController.swift
//  ColorPicker
//
//  Created by Apollonian on 16/7/18.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class RGBAViewController: UIViewController {

    override var prefersStatusBarHidden: Bool{
        return true
    }

    var value: UIColor{
        get{
            return UIColor(red: r, green: g, blue: b, alpha: a)
        }
        set{
            view?.backgroundColor = newValue
            newValue.getRed(&r, green: &g, blue: &b, alpha: &a)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        value = manager.lineColor
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        manager.lineColor = value
    }

    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var aLabel: UILabel!

    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    @IBOutlet weak var aSlider: UISlider!

    fileprivate var r: CGFloat = 0 {
        willSet{
            rLabel.text = "\(newValue * 255)"
            rSlider.setValue(Float(newValue), animated: true)
        }
    }
    fileprivate var g: CGFloat = 0 {
        willSet{
            gLabel.text = "\(newValue * 255)"
            gSlider.setValue(Float(newValue), animated: true)
        }
    }
    fileprivate var b: CGFloat = 0 {
        willSet{
            bLabel.text = "\(newValue * 255)"
            bSlider.setValue(Float(newValue), animated: true)
        }
    }
    fileprivate var a: CGFloat = 0 {
        willSet{
            aLabel.text = "\(newValue * 255)"
            aSlider.setValue(Float(newValue), animated: true)
        }
    }

    @IBAction func valueChanged(_ sender: UISlider) {
        switch sender.tag{
        case 0:
            r = CGFloat(sender.value)
        case 1:
            g = CGFloat(sender.value)
        case 2:
            b = CGFloat(sender.value)
        case 3:
            a = CGFloat(sender.value)
        default:
            break
        }
        view.backgroundColor = value
    }

}
