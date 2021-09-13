
import Foundation

public struct DictionaryLookupSearchTree<Tree: SearchTree, Value>: SearchTree where Tree.ID: Hashable {
    public typealias ID = Value

    let tree: Tree
    let values: [Tree.ID : Value]

    public func performSearch(query: String, maxDistance: Int, relevantAfter: Double, options: SearchOptions) -> [SearchResult<ID>] {
        return tree.performSearch(query: query, maxDistance: maxDistance, relevantAfter: relevantAfter, options: options).compactMap { result in
            guard let value = values[result.value] else { return nil }
            return SearchResult(value: value, occurences: result.occurences)
        }
    }
}

extension DictionaryLookupSearchTree: Encodable where Tree: Encodable, Tree.ID: Encodable, Value: Encodable { }

extension DictionaryLookupSearchTree: Decodable where Tree: Decodable, Tree.ID: Decodable, Value: Decodable { }
