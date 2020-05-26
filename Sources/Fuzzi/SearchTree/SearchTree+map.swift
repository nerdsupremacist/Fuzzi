
import Foundation

extension SearchTree {

    func map<T>(_ transform: @escaping (ID) -> T) -> AnySearchTree<T> {
        return AnySearchTree(_search: { self.search(query: $0, maxDistance: $1, relevantAfter: $2, options: $3).map { $0.map(transform) } })
    }

}
