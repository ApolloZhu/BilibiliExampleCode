//
//  ViewController.swift
//  Steps
//
//  Created by Apollonian on 8/1/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit
import HealthKit

// 10000 step -> 350.88 kilocalorie, 5 kilometer

class ViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!

    @IBAction func save() {
        if textfield.isEditing{
            textfield.resignFirstResponder()
        }
        var steps = 100000 // 默认保存 十万 步
        if let text = textfield.text{
            if let integer = Int(text.trimmingCharacters(in: NSCharacterSet.decimalDigits.inverted)){
                steps = integer
            }
        }
        HKDataManager.shared.save(Double(steps), ofType: .stepCount, autocomplete: true)
    }
}
