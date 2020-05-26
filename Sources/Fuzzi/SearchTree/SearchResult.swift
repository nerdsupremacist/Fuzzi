
import Foundation

public struct Occurence {
    public let component: String
    public let coefficient: Double
}

public struct SearchResult<ID> {

    public let value: ID
    public fileprivate(set) var occurences: [Occurence]
}

extension SearchResult {

    init(value: ID) {
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
        return occurences
            .enumerated()
            .reduce(0.0) { $0 + $1.element.coefficient + pow(2, -Double($1.offset)) } / 2.0
    }

}

extension SearchResult {

    func map<T>(_ transform: (ID) throws -> T) rethrows -> SearchResult<T> {
        return SearchResult<T>(value: try transform(value), occurences: occurences)
    }

}
