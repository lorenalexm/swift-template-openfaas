import Foundation

let handler = Handler()
let context = String(data: FileHandle.standardInput.availableData, encoding: .utf8)

print(handler.process(with: context!))
