
import Foundation

public struct SearchOptions: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension SearchOptions {
    public static let sortByScore = SearchOptions(rawValue: 1 << 0)
    public static let caseInsensitive = SearchOptions(rawValue: 1 << 1)

    public static let standard: SearchOptions = [.sortByScore, .caseInsensitive]
}

public struct SearchTree<Value: Searchable> {
    let word: String
    var values: [Value]
    var children: [Int : SearchTree<Value>]
}

extension SearchTree: Encodable where Value: Encodable { }

extension SearchTree: Decodable where Value: Decodable { }

extension SearchTree {
    
    public struct SearchResult {
        
        public struct Occurence {
            public let word: String
            public let coefficient: Double
        }
        
        public let value: Value
        public fileprivate(set) var occurences: [Occurence]
    }
    
}

extension SearchTree.SearchResult {
    
    init(value: Value) {
        self.value = value
        occurences = []
    }
    
    mutating func append(_ occurence: Occurence) {
        occurences.append(occurence)
    }
    
    public var sum: Double {
        return occurences.reduce(0.0) { $0 + $1.coefficient }
    }
    
    public var score: Double {
        return occurences.enumerated().reduce(0.0) { $0 + $1.element.coefficient + pow(2, -Double($1.offset)) } / 2.0
    }
    
}

extension SearchTree {
    
    init(word: String) {
        self.init(word: word, values: [], children: [:])
    }
    
    private mutating func append(value: Value, for word: String) {
        guard word != self.word else {
            return values.append(value)
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
    
    func searchWord(accumulator: [Value : SearchResult],
                    query: String,
                    maxDistance: Int,
                    relevantAfter: Double,
                    options: SearchOptions) -> [Value : SearchResult] {
        
        var accumulator = accumulator
        
        let currentDistance = word.distance(to: query)
        let upperAllowed = currentDistance + maxDistance
        let lowerAllowed = max(0, currentDistance - maxDistance)
        
        
        let coefficient = Search.coefficient(value: query, using: word, options: options)
        let occurence = SearchResult.Occurence(word: word, coefficient: coefficient)
        
        if currentDistance <= maxDistance, coefficient >= relevantAfter {
            values.forEach { value in
                accumulator[value, default: .init(value: value)].append(occurence)
            }
        }
        
        let range = (lowerAllowed...upperAllowed)
        let children = range.compactMap { self.children[$0] }
        return children.reduce(accumulator) { $1.searchWord(accumulator: $0,
                                                            query: query,
                                                            maxDistance: maxDistance,
                                                            relevantAfter: relevantAfter,
                                                            options: options) }
    }
    
    public func search(query: String,
                       maxDistance: Int = 4,
                       relevantAfter: Double = 0.6,
                       options: SearchOptions = .standard) -> [SearchResult] {
        
        guard !options.contains(.sortByScore) else {
            
            return search(query: query,
                          maxDistance: maxDistance,
                          relevantAfter: relevantAfter,
                          options: options.subtracting(.sortByScore)).sorted { $0.score >= $1.score }
        }
        
        let dictionary =  query.components(separatedBy: " ").reduce([:]) { dict, word in
            return searchWord(accumulator: dict,
                              query: word,
                              maxDistance: maxDistance,
                              relevantAfter: relevantAfter,
                              options: options)
        }
        return Array(dictionary.values)
    }
    
    public func search(query: String,
                       maxDistance: Int = 4,
                       relevantAfter: Double = 0.6,
                       options: SearchOptions = .standard) -> [Value] {
        
        return search(query: query,
                      maxDistance: maxDistance,
                      relevantAfter: relevantAfter,
                      options: options).map { $0.value }
    }
    
}

public protocol Searchable: Hashable {
    var searchableProperties: [KeyPath<Self, String>] { get }
}

extension Searchable {
    
    var words: Set<String> {
        return Set(searchableProperties.flatMap { path in
            return self[keyPath: path].components(separatedBy: " ")
        })
    }
    
}

extension Sequence where Element: Searchable {
    
    public func searchTree() -> SearchTree<Element>? {
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
    
    static func coefficient(value: String, using key: String, options: SearchOptions) -> Double {
        let distance = key.distance(to: value, options: options)
        let maxCount = max(value.count, key.count)
        return 1.0 - Double(distance) / Double(maxCount)
    }
    
}

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
