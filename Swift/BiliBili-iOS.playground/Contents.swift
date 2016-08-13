import Foundation
import UIKit

// Mark: Generics?
/*extension Array{
    /// Should be abitious but not
    public mutating func append<C : Collection where C.Iterator.Element == Element>(_ newElement: C){
        print("Executed Generics C Method")
        for element in newElement{
            self.append(element)
        }
    }
    public mutating func append<S : Sequence where S.Iterator.Element == Element>(_ newElement: S){
        print("Executed Generics S Method")
        for element in newElement{
            self.append(element)
        }
    }
    // public mutating func append(_ newElement: Element){
        // Ambitious
    // }
}

var intArray: Array<Int> = []
intArray.append(1)
intArray.append([1,2,3]) // append<C>(_ newElement: C)

var anyArray: Array<Any> = []
anyArray.append(1)
anyArray.append([1,"2",3]) // append<C>(_ newElement: C)
anyArray.append(["A":2,"C":3]) // append(_ newElement: Element)
anyArray.append(1..<3)
*/
/*
protocol CanvasDrawing{
    associatedtype Style = Any
}

class Brush: CanvasDrawing{
    typealias Style = Any
}

class AnotherBrush: CanvasDrawing{
    public typealias Style = Int
}

class Canvas<Style>: CanvasDrawing{
    func draw(using any: Any){
        print("Any")
    }
    func draw<T: CanvasDrawing where T.Style == Style>(using style: T){
        print("Generics")
    }
    func draw(using style: Style){
        print("Specified")
    }
}

let canvas : Canvas<Any> = Canvas()
canvas.draw(using: Brush())
canvas.draw(using: (Brush() as Any))
canvas.draw(using: canvas)
canvas.draw(using: AnotherBrush())*/

// Mark: URL
/*
import Foundation
let url = URL(string: "link")
var request = URLRequest(url: url!)
request.httpMethod = "POST"
request.httpBody = "Body".data(using: .utf8)
request.timeoutInterval = 10
let session = URLSession.shared
/* dataTask, downloadTask, uploadTask */
let task = session.dataTask(with: request) {(data, reqsponse, error) in
    DispatchQueue.main.async {
        // Do something
    }
}
task.resume
 */
/*
var max = -1
for i in 0..<100000{
    var tmp = Int(arc4random_uniform(256))
    if tmp > max{
        max = tmp
    }
}
max*/
/*
let text: NSString = "Lorem"
let path = NSHomeDirectory() + "/myFile.txt"
do{
    try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8.rawValue)
} catch {
    print(error)
}*/
