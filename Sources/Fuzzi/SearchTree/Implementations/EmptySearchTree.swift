
import Foundation

struct EmptySearchTree<ID: Hashable, Value: Searchable>: MutableSearchTree {
    func performSearch(query: String, maxDistance: Int, relevantAfter: Double, options: SearchOptions) -> [SearchResult<ID>] {
        return []
    }

    func appending(id: ID, value: Value) -> AnyMutableSearchTree<ID, Value> {
        guard let component = components(for: value).first?.key else { return eraseToAnyMutableSearchTree() }
        var tree = BKSearchTree<ID, Value>(component: component)
        tree.append(id: id, value: value)
        return tree.eraseToAnyMutableSearchTree()
    }
}
