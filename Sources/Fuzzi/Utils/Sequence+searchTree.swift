
import Foundation

extension Dictionary where Value: Searchable {

    func keySearchTree() -> AnySearchTree<Key> {
        let tree = EmptySearchTree<Key, Value>().eraseToAnyMutableSearchTree()
        return reduce(tree) { $0.appending(id: $1.key, value: $1.value) }.eraseToAnySearchTree()
    }

    func valueSearchTree() -> AnySearchTree<Value> {
        return keySearchTree().map { self[$0]! }
    }

}

extension Sequence where Element: Searchable {

    public func searchTree() -> AnySearchTree<Element> {
        let dictionary = Dictionary(uniqueKeysWithValues: enumerated().map { ($0.offset, $0.element) })
        return dictionary.valueSearchTree()
    }

}
