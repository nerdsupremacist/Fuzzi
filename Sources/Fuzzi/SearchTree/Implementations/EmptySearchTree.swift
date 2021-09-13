
import Foundation

struct EmptySearchTree<ID: Hashable, Value: Searchable>: MutableSearchTree {
    func performSearch(query: String, maxDistance: Int, relevantAfter: Double, options: SearchOptions) -> [SearchResult<ID>] {
        return []
    }

    func appending(id: ID, components: [String : Double]) -> AnyMutableSearchTree<ID> {
        guard let component = components.first?.key else { return eraseToAnyMutableSearchTree() }
        var tree = BKSearchTree<ID>(component: component)
        tree.append(id: id, components: components)
        return tree.eraseToAnyMutableSearchTree()
    }
}
