
import Foundation

extension Dictionary where Value: Searchable {

    func keySearchTree() -> StandardSearchTree<Key> {
        let tree = StandardSearchTree<Key>()
        return reduce(tree) { $0.appending(id: $1.key, components: components(for: $1.value)) }
    }

    func valueSearchTree() -> DictionaryLookupSearchTree<StandardSearchTree<Key>, Value> {
        return DictionaryLookupSearchTree(tree: keySearchTree(), values: self)
    }

}

extension RandomAccessCollection where Element: Searchable, Index: Hashable {

    public func searchTree() -> CollectionLookupSearchTree<StandardSearchTree<Index>, Self> {
        let dictionary = Dictionary(uniqueKeysWithValues: indices.map { ($0, self[$0]) })
        let tree = dictionary.keySearchTree()
        return CollectionLookupSearchTree(tree: tree, values: self)
    }

}

extension Sequence where Element: Hashable {

    public func searchTree<Content : Searchable>(@SearchableBuilder content: (Element) -> Content) -> StandardSearchTree<Element> {
        let dictionary = Dictionary(map { ($0, [content($0)]) }) { lhs, rhs in
            return lhs + rhs
        }
        
        return dictionary.keySearchTree()
    }

}

extension Sequence where Element == String {

    public func searchTree() -> StandardSearchTree<String> {
        return searchTree { Text($0) }
    }

}

extension Sequence where Element: Identifiable {

    public func searchTree<Content : Searchable>(@SearchableBuilder content: (Element) -> Content) -> DictionaryLookupSearchTree<StandardSearchTree<Element.ID>, Element> {
        let keyLookup = Dictionary(map { ($0.id, $0) }) { $1 }
        let dictionary = keyLookup.mapValues { content($0) }
        return DictionaryLookupSearchTree(tree: dictionary.keySearchTree(), values: keyLookup)
    }

}
