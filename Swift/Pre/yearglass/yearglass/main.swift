//
//  main.swift
//  yearglass
//
//  Created by Apollo Zhu on 3/4/17.
//  Copyright © 2017 WWITDC. All rights reserved.
//

import Foundation

let prompt = "Year Progress: "
let filled = "▓"
let empty  = "░"

let calendar = Calendar.current
let today = Date()

var start = Date()
var interval: TimeInterval = 0
_ = calendar.dateInterval(of: .year, start: &start, interval: &interval, for: today)
let daysInYear = calendar.dateComponents([.day], from: start, to: start.addingTimeInterval(interval)).day!
let daysPassed = calendar.ordinality(of: .day, in: .year, for: today)!
let percentage = Double(daysPassed)/Double(daysInYear)

let formattedPercentage = NumberFormatter.localizedString(from: percentage as NSNumber, number: .percent)

var width: Int {
    var size = winsize()
    _ = ioctl(STDOUT_FILENO, TIOCGWINSZ, &size)
    return Int(size.ws_col)
}

let widthForBar = width - 1 - prompt.characters.count - formattedPercentage.characters.count
let widthForFilled = Int(percentage * Double(widthForBar))
let countForFilled = widthForFilled/filled.characters.count
let countForEmpty  = (widthForBar - widthForFilled) / empty.characters.count

// "a"*3 -> aaa
func *(str: String, count: Int) -> String {
//    var built = ""
//    for _ in 0..<count {
//        built += str
//    }
//    return built
    return count < 0 ? "" : (0..<count).reduce("") { (built,_) in built+str }
}

print("\(prompt)\(formattedPercentage) \(filled*countForFilled)\(empty*countForEmpty)")
