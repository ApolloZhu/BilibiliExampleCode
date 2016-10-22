//
//  DataManager.swift
//  Steps
//
//  Created by Apollonian on 8/1/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import Foundation
import HealthKit

public typealias HKDataSet = (unit: HKUnit, completion: ((_ value: Double) -> ())?)

class HKDataManager{
    public static let shared = HKDataManager()
    
    private init(){
        if HKHealthStore.isHealthDataAvailable(){
            let writeTypes: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!, HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!, HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!]
            HKHealthStore().requestAuthorization(toShare: writeTypes, read: []) {_,_ in}
        }
    }

    public var database: [HKQuantityTypeIdentifier:HKDataSet]{
        return HKDataManager.completions
    }

    open static let completions : [HKQuantityTypeIdentifier:HKDataSet] = [
        .stepCount:(
            .count(),
            {
                shared.save($0 * 35.088, ofType: .activeEnergyBurned)
                shared.save($0 / 2, ofType: .distanceWalkingRunning)
            }
        ),

        .activeEnergyBurned: (
            .calorie(),
            nil
        ),

        .distanceWalkingRunning: (
            .meter(), {
                shared.save($0 * 2, ofType: .stepCount)
            }
        )
    ]

    public func save(_ value: Double, ofType type: HKQuantityTypeIdentifier, autocomplete: Bool = false){
        guard database.keys.contains(type) else {return}

        let quantityType = HKQuantityType.quantityType(forIdentifier: type)!
        let quantity = HKQuantity(unit: database[type]!.unit, doubleValue: value)
        let date = Date()
        let metadata: [String : AnyObject] = [HKMetadataKeyDeviceName:"AZOS" as AnyObject]

        let sample = HKQuantitySample(
            type: quantityType,
            quantity: quantity,
            start: date,
            end: date,
            metadata: metadata
        )

        HKHealthStore().save(sample) {_,_ in
            if autocomplete{
                if let completion = self.database[type]!.completion{
                    completion(value)
                }
            }
        }
    }
}
