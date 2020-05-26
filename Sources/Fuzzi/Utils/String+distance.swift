
import Foundation

extension String {

    public func distance(to other: String, options: SearchOptions = .standard) -> Int {

        guard !options.contains(.caseInsensitive) else {
            return lowercased().distance(to: other.lowercased(), options: options.subtracting(.caseInsensitive))
        }
        // Dynamic programming method to read the distance
        guard count > 0 else { return other.count }
        guard other.count > 0 else { return count }
        let vector = Array(1...Int(count))
        let lastVector = other.enumerated().reduce(vector) { lastVector, current in
            return self.enumerated().reduce([]) { newVector, item in
                let up = newVector.last ?? (current.offset + 1)
                let left = lastVector[item.offset]
                let diagonal = item.offset > 0 ? lastVector[item.offset - 1] : current.offset
                let cost = current.element != item.element ? 1 : 0
                return newVector + [min(up + 1, min(left + 1, diagonal + cost))]
            }
        }
        return lastVector.last ?? 0
    }

}
