
import Foundation

public struct AnyMutableSearchTree<ID>: MutableSearchTree {
    let _appending: (ID, [String : Double]) -> AnyMutableSearchTree<ID>
    let _search: (String, Int, Double, SearchOptions) -> [SearchResult<ID>]

    init<T: MutableSearchTree>(_ tree: T) where T.ID == ID {
        self._appending = { tree.appending(id: $0, components: $1).eraseToAnyMutableSearchTree() }
        self._search = { tree.performSearch(query: $0, maxDistance: $1, relevantAfter: $2, options: $3) }
    }

    public func appending(id: ID, components: [String : Double]) -> AnyMutableSearchTree<ID> {
        return _appending(id, components)
    }

    public func performSearch(query: String, maxDistance: Int, relevantAfter: Double, options: SearchOptions) -> [SearchResult<ID>] {
        return _search(query, maxDistance, relevantAfter, options)
    }

    public func eraseToAnySearchTree() -> AnySearchTree<ID> {
        return AnySearchTree(_search: _search)
    }

    public func eraseToAnyMutableSearchTree() -> AnyMutableSearchTree<ID> {
        return self
    }
}
