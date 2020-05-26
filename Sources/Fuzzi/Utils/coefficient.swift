
import Foundation

enum Search {

    static func coefficient(value: String, using key: String, options: SearchOptions) -> Double {
        let distance = key.distance(to: value, options: options)
        let maxCount = max(value.count, key.count)
        return 1.0 - Double(distance) / Double(maxCount)
    }

}
