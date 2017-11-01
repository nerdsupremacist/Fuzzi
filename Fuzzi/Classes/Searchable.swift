
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

public struct SearchableProperty<Parent> {
    let path: KeyPath<Parent, String>
    let weight: Int
    
    public init(path: KeyPath<Parent, String>, weight: Int = 1) {
        self.path = path
        self.weight = weight
    }
}

public protocol Searchable {
    typealias Property = SearchableProperty<Self>
    var searchableProperties: [Property] { get }
}

public struct SearchResult<Value> {
    public let value: Value
    public let score: Double
}

extension Sequence where Element == String {
    
    public func search(for key: String, options: SearchOptions = .standard, relevantAfter: Double = 0.6) -> [SearchResult<String>] {
        
        guard !options.contains(.removeUnuseful) else {
            return search(for: key, options: options.subtracting(.removeUnuseful)).filter { $0.score >= relevantAfter }
        }
        guard !options.contains(.sortByGrade) else {
            return search(for: key, options: options.subtracting(.sortByGrade)).sorted { $0.score <= $1.score }
        }
        return parallelMap { Search.score(value: $0, using: key, options: options) }
    }
    
    public func simpleSearch(for key: String, options: SearchOptions = .standard) -> [String] {
        return search(for: key, options: options).map { $0.value }
    }
    
}

extension Sequence where Element: Searchable {
    
    public func search(for key: String, options: SearchOptions = .standard, relevantAfter: Double = 0.6) -> [SearchResult<Element>] {
        
        guard !options.contains(.removeUnuseful) else {
            return search(for: key, options: options.subtracting(.removeUnuseful)).filter { $0.score >= relevantAfter }
        }
        guard !options.contains(.sortByGrade) else {
            return search(for: key, options: options.subtracting(.sortByGrade)).sorted { $0.score <= $1.score }
        }
        return parallelMap { Search.score(value: $0, using: key, options: options) }
    }
    
    public func simpleSearch(for key: String, options: SearchOptions = .standard) -> [Element] {
        return search(for: key, options: options).map { $0.value }
    }
    
}

enum Search {
    
    static func score(value: String, using key: String, options: SearchOptions = .standard) -> SearchResult<String> {
        
        guard !options.contains(.caseInsensitive) else {
            
            return score(value: value.lowercased(),
                         using: key.lowercased(),
                         options: options.subtracting(.caseInsensitive))
        }
        let distance = key.distance(to: value)
        let maxCount = max(value.count, key.count)
        let coefficient = Double(distance) / Double(maxCount)
        return SearchResult(value: value, score: 1.0 - coefficient)
    }
    
    static func score<Value: Searchable>(value: Value, using key: String, options: SearchOptions = .standard) -> SearchResult<Value> {
        
        let totalWeights = value.searchableProperties.reduce(0) { $0 + $1.weight }
        
        let results = value.searchableProperties.parallelMap { property -> Double in
            let coefficient = Double(property.weight) / Double(totalWeights)
            let score = Search.score(value: value[keyPath: property.path], using: key, options: options).score
            return coefficient * score
        }
        
        return SearchResult(value: value, score: results.reduce(0.0, +))
    }
    
}

extension String {
    
    func distance(to other: String) -> Int {
        // Dynamic programming method to read the distance
        guard count > 0 else { return other.count }
        guard other.count > 0 else { return count }
        let vector = Array(0..<Int(count))
        let lastVector = other.enumerated().reduce(vector) { lastVector, current in
            return self.enumerated().reduce([]) { newVector, item in
                let up = newVector.last ?? current.offset
                let left = lastVector[item.offset]
                let diagonal = item.offset > 0 ? lastVector[item.offset - 1] : 0
                let cost = current.element != item.element ? 1 : 0
                return newVector + [min(up + 1, min(left + 1, diagonal + cost))]
            }
        }
        return lastVector.last ?? 0
    }
    
}
