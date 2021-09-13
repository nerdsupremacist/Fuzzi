
import Foundation

public struct AnySearchTree<ID>: SearchTree {
    let _search: (String, Int, Double, SearchOptions) -> [SearchResult<ID>]

    public func performSearch(query: String, maxDistance: Int, relevantAfter: Double, options: SearchOptions) -> [SearchResult<ID>] {
        return _search(query, maxDistance, relevantAfter, options)
    }

    public func eraseToAnySearchTree() -> AnySearchTree<ID> {
        return self
    }
}

extension AnySearchTree {

    init<T: SearchTree>(_ tree: T) where T.ID == ID {
        self._search = { tree.searchResults(query: $0, maxDistance: $1, relevantAfter: $2, options: $3) }
    }
    
}
