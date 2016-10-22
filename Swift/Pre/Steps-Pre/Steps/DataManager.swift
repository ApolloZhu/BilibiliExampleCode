//
//  DataManager.swift
//  Steps
//
//  Created by Apollonian on 8/1/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import Foundation
import HealthKit

extension Date{
    public var intervalSinceThatMidnight: TimeInterval{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        var date = formatter.string(from: self)
        date = date.substring(to: date.index(date.startIndex, offsetBy: 8)) + "000000"
        return self.timeIntervalSince(formatter.date(from: date)!)
    }

    public static var today: Date{
        let date = Date()
        return date.addingTimeInterval(-date.intervalSinceThatMidnight)
    }
}

extension String{
    func trimmingCharacters(notIn set: CharacterSet) -> String{
        return self.unicodeScalars.reduce("") {
            $0 + (set.contains($1) ? String($1) : "")
        }
    }
}

public typealias HKDataSet = (unit: HKUnit, completion: ((value: Double) -> Void)?)

class DataManager{
    private init(){}

    public static func setup(){
        if HKHealthStore.isHealthDataAvailable(){
            let writeTypes: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!, HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!, HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!]
            let readTypes: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!]
            HKHealthStore().requestAuthorization(toShare: writeTypes, read: readTypes) {_,_ in
                UserDefaults.standard.setValue(Date(), forKey: "lastSaving")
            }
        }
    }

    public static let database : [HKQuantityTypeIdentifier:HKDataSet] = [
        .stepCount:(
            .count(),
            {
                DataManager.save(value: $0 * 35.088, type: .activeEnergyBurned)
                DataManager.save(value: $0 / 2, type: .distanceWalkingRunning)
            }
        ),

        .activeEnergyBurned: (
            .calorie(),
            nil
        ),

        .distanceWalkingRunning: (
            .meter(), {
                DataManager.save(value: $0 * 2, type: .stepCount)
            }
        )
    ]

    public static func save(value: Double, type: HKQuantityTypeIdentifier, autocomplete: Bool = false){
        guard database.keys.contains(type) else {return}
        let quantityType = HKQuantityType.quantityType(forIdentifier: type)!
        let quantity = HKQuantity(unit: database[type]!.unit, doubleValue: value)

        let date = Date()
        let lastSaveingDate = UserDefaults.standard.value(forKey: "lastSaving") as! Date
        let metadata: [String : AnyObject] = [HKMetadataKeyDeviceName:"AZOS"]
        let sample = HKQuantitySample(
            type: quantityType,
            quantity: quantity,
            start: max(lastSaveingDate, .today),
            end: date,
            metadata: metadata
        )

        HKHealthStore().save(sample) {_,_ in
            if autocomplete{
                if let completion = database[type]!.completion{
                    completion(value: value)
                }
            } else {
                UserDefaults.standard.setValue(date, forKey: "lastSaving")
            }
        }
    }
}
