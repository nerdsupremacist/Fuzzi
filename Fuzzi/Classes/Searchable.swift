
import Foundation

public struct SearchOptions: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension SearchOptions {
    public static let removeUnuseful = SearchOptions(rawValue: 1 << 0)
    public static let sortByGrade = SearchOptions(rawValue: 1 << 1)
    public static let caseInsensitive = SearchOptions(rawValue: 1 << 2)

    public static let standard: SearchOptions = [.removeUnuseful, .sortByGrade, .caseInsensitive]
}

public struct SearchTree<Value: Searchable>: Codable {
    let word: String
    var values: Set<Value>
    var children: [Int : SearchTree<Value>]
}

extension SearchTree {
    
    init(word: String) {
        self.init(word: word, values: [], children: [:])
    }
    
    private mutating func append(value: Value, for word: String) {
        guard word != self.word else {
            return values.formUnion([value])
        }
        let distance = self.word.distance(to: word)
        children[distance, default: .init(word: word)].append(value: value, for: word)
    }
    
    public mutating func append(_ value: Value) {
        value.words.forEach { append(value: value, for: $0) }
    }
    
    public func appending(value: Value) -> SearchTree<Value> {
        var tree = self
        tree.append(value)
        return tree
    }
    
    func searchWord(query: String, maxDistance: Int = 4, relevantAfter: Double = 0.4) -> Set<Value> {
        
        let currentDistance = word.distance(to: query)
        let upperAllowed = currentDistance + maxDistance
        let lowerAllowed = max(0, currentDistance - maxDistance)
        
        let range = (lowerAllowed...upperAllowed)
        let others = range.flatMap { self.children[$0]?.searchWord(query: query, maxDistance: maxDistance) ?? [] }
        let coefficient = Search.coefficient(value: word, using: query)
        return Set(others + (coefficient <= relevantAfter ? values : []))
    }
    
    public func search(query: String, maxDistance: Int = 4, relevantAfter: Double = 0.4) -> Set<Value> {
        return query.components(separatedBy: " ").reduce([]) { set, word in
            return set.union(searchWord(query: word, maxDistance: maxDistance, relevantAfter: relevantAfter))
        }
    }
    
}

public protocol Searchable: Codable, Hashable {
    var searchableProperties: [KeyPath<Self, String>] { get }
}

extension Searchable {
    
    var words: Set<String> {
        return Set(searchableProperties.flatMap { path in
            return self[keyPath: path].components(separatedBy: " ")
        })
    }
    
}

public struct SearchResult<Value> {
    public let value: Value
    public let score: Double
}

extension Sequence where Element: Searchable {
    
    public func tree() -> SearchTree<Element>? {
        guard let firstWord = flatMap({ $0.words }).first else {
            return nil
        }
        let tree = SearchTree<Element>(word: firstWord)
        return reduce(tree) { tree, value in
            return tree.appending(value: value)
        }
    }
    
}

enum Search {
    
    static func coefficient(value: String, using key: String, options: SearchOptions = .standard) -> Double {
        
        guard !options.contains(.caseInsensitive) else {
            
            return coefficient(value: value.lowercased(),
                               using: key.lowercased(),
                               options: options.subtracting(.caseInsensitive))
        }
        let distance = key.distance(to: value)
        let maxCount = max(value.count, key.count)
        return Double(distance) / Double(maxCount)
    }
    
}

extension String {
    
    public func distance(to other: String) -> Int {
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
