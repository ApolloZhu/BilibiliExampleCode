//
//  Filter.swift
//  CGFilter
//
//  Created by Apollonian on 9/14/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

extension CGImage{
    var bitmapContext: CGContext{
        get{
            let bytesCount = bytesPerRow * height
            let bitmapData = malloc(bytesCount)
            let context = CGContext(data: bitmapData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
            context?.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))
            return context!
        }
    }
}

class Filter{
    static func mono(image uiImage: UIImage) -> UIImage{
        let image = uiImage.cgImage!
        let context = image.bitmapContext
        let pixelData = context.data
        let data = pixelData?.assumingMemoryBound(to: UInt8.self)

        for x in 0..<image.width{
            for y in 0..<image.height{
                var avg = 0.0
                let flag = 4 * ((image.width * y) + x)
                for i in 1...3{
                    avg += Double(data![flag + i])
                }
                avg /= 3
                for i in 1...3{
                    data![flag + i] = UInt8(avg)
                }
            }
        }
        let processedImage = context.makeImage()
        return UIImage(cgImage: processedImage!)
    }
}
