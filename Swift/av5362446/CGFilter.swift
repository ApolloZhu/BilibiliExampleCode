import UIKit

extension CGImage{
    var bitmapContext: CGContext{
        get{
            let bytesCount = bytesPerRow * height
            let bitmapData = malloc(bytesCount)
            let context = CGContext(data: bitmapData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
            context?.draw(in: CGRect(x: 0, y: 0, width: width, height: height), image: self)
            return context!
        }
    }
}

extension UIImage{
    func new(with filter: Filter) -> UIImage{
        let image = self.cgImage!
        let width = image.width
        let height = image.height
        let context = image.bitmapContext

        let pixelData = context.data
        let data = pixelData?.assumingMemoryBound(to: UInt8.self)

        for x in 0..<width{
            for y in 0..<height{
                var currentPixelARGB = [Double]()
                let flag = 4 * ((width * y) + x)
                for i in 0...3{
                    currentPixelARGB.append(Double(data[flag + i]))
                }
                let processedARGB = filter(currentPixelARGB: currentPixelARGB, x: x, y: y, width: width, height: height, evaluateFlag: {4 * (($2 * $1) + $0)}, completeData: data)
                for i in 0...3{
                    data[flag + i] = UInt8(processedARGB[i])
                }
            }
        }
        let processedImage = context.makeImage()
        return UIImage(cgImage: processedImage!)
    }
}

typealias Filter = (_ currentPixelARGB: [Double], _ x: Int, _ y: Int, _ width: Int, _ height: Int, _ evaluateFlag: (_ x: Int, _ y: Int, _ width: Int) -> Int, _ completeData: UnsafeMutablePointer<UInt8>) -> [Double]

let mono : Filter = { (currentPixelARGB, _, _, _, _, _, _) in
    let avg = (currentPixelARGB[1] + currentPixelARGB[2] + currentPixelARGB[3]) / 3
    return [currentPixelARGB[0],avg, avg, avg]
}

let blur: Filter = { (currentPixelARGB, x, y, width, height, evaluateFlag, completeData) in
    var sumARGB = [0.0,0,0,0]
    var pixelCount = 0.0
    for i in x - 3..<x + 4{
        for j in y-3..<y+4{
            if i < 0 || j < 0 || i >= width || j >= height{
                continue
            }
            let flag = evaluateFlag(x: x, y: y, width: width)
            for i in 1...3{
                sumARGB[i] += Double(completeData[flag + i])
            }
            pixelCount += 1
        }
    }
    return [currentPixelARGB[0], sumARGB[1] / pixelCount, sumARGB[2] / pixelCount, sumARGB[3] / pixelCount]
}

/* MARK: OOP Style
class FilterClass{
    func mono(currentPixelARGB: [Double], x: Int, y: Int, width: Int, height: Int, evaluateFlag: (_ x: Int, _ y: Int, _ width: Int) -> Int, completeData: UnsafeMutablePointer<UInt8>) -> [Double]{
        let avg = (currentPixelARGB[1] + currentPixelARGB[2] + currentPixelARGB[3]) / 3
        return [currentPixelARGB[0],avg, avg, avg]
    }

    func blur(currentPixelARGB: [Double], x: Int, y: Int, width: Int, height: Int, evaluateFlag: (_ x: Int, _ y: Int, _ width: Int) -> Int, completeData: UnsafeMutablePointer<UInt8>) -> [Double]{
        var sumARGB = [0.0,0,0,0]
        var pixelCount = 0.0
        for i in x - 3..<x + 4{
            for j in y-3..<y+4{
                if i < 0 || j < 0 || i >= width || j >= height{
                    continue
                }
                let flag = evaluateFlag(x: x, y: y, width: width)
                for i in 1...3{
                    sumARGB[i] += Double(completeData[flag + i])
                }
                pixelCount += 1
            }
        }
        return [currentPixelARGB[0], sumARGB[1] / pixelCount, sumARGB[2] / pixelCount, sumARGB[3] / pixelCount]
    }
} */


/* MARK: Usage
 let image = UIImage(named: "swift.png")!

 // Closure
 let image1 = image.new{ (currentPixelARGB, _, _, _, _, _, _) in
 let avg = (currentPixelARGB[1] + currentPixelARGB[2] + currentPixelARGB[3]) / 3
 return [currentPixelARGB[0],avg, avg, avg]
 }

 // Typealias
 let image2 = image.new(with: mono)

 // Function
 let image3 = image.new(with: FilterClass().blur)
 */
