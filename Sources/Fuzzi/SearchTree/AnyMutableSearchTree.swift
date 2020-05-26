
import Foundation

public struct AnyMutableSearchTree<ID, Value: Searchable>: MutableSearchTree {
    let _appending: (ID, Value) -> AnyMutableSearchTree<ID, Value>
    let _search: (String, Int, Double, SearchOptions) -> [SearchResult<ID>]

    init<T: MutableSearchTree>(_ tree: T) where T.ID == ID, T.Value == Value {
        self._appending = { tree.appending(id: $0, value: $1).eraseToAnyMutableSearchTree() }
        self._search = { tree.search(query: $0, maxDistance: $1, relevantAfter: $2, options: $3) }
    }

    public func appending(id: ID, value: Value) -> AnyMutableSearchTree<ID, Value> {
        return _appending(id, value)
    }

    public func search(query: String, maxDistance: Int, relevantAfter: Double, options: SearchOptions) -> [SearchResult<ID>] {
        return _search(query, maxDistance, relevantAfter, options)
    }

    public func eraseToAnySearchTree() -> AnySearchTree<ID> {
        return AnySearchTree(_search: _search)
    }

    public func eraseToAnyMutableSearchTree() -> AnyMutableSearchTree<ID, Value> {
        return self
    }
}
