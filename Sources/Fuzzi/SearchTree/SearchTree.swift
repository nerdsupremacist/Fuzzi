
import Foundation

public protocol SearchTree {
    associatedtype ID

    func search(query: String, maxDistance: Int, relevantAfter: Double, options: SearchOptions) -> [SearchResult<ID>]
    func eraseToAnySearchTree() -> AnySearchTree<ID>
}

extension SearchTree {

    public func search(query: String,
                       maxDistance: Int = 4,
                       relevantAfter: Double = 0.6,
                       options: SearchOptions = .standard) -> [SearchResult<ID>] {

        return search(query: query,
                      maxDistance: maxDistance,
                      relevantAfter: relevantAfter,
                      options: options)
    }

    public func search(query: String,
                       maxDistance: Int = 4,
                       relevantAfter: Double = 0.6,
                       options: SearchOptions = .standard) -> [ID] {

        return search(query: query,
                      maxDistance: maxDistance,
                      relevantAfter: relevantAfter,
                      options: options).map { $0.value }
    }

}


extension SearchTree {

    public func eraseToAnySearchTree() -> AnySearchTree<ID> {
        return AnySearchTree(self)
    }

}
