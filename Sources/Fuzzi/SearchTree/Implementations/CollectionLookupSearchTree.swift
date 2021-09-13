
import Foundation

public struct CollectionLookupSearchTree<Tree: SearchTree, Collection: RandomAccessCollection>: SearchTree where Tree.ID == Collection.Index {
    public typealias ID = Collection.Element

    let tree: Tree
    let values: Collection

    public func performSearch(query: String, maxDistance: Int, relevantAfter: Double, options: SearchOptions) -> [SearchResult<ID>] {
        return tree.performSearch(query: query, maxDistance: maxDistance, relevantAfter: relevantAfter, options: options).compactMap { result in
            return SearchResult(value: values[result.value], occurences: result.occurences)
        }
    }
}

extension CollectionLookupSearchTree: Encodable where Tree: Encodable, Collection: Encodable { }

extension CollectionLookupSearchTree: Decodable where Tree: Decodable, Collection: Decodable { }
