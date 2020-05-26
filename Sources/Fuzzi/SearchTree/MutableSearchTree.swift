
import Foundation

public protocol MutableSearchTree: SearchTree {
    associatedtype Value: Searchable
    associatedtype Next: MutableSearchTree where Next.ID == ID, Next.Value == Value

    func appending(id: ID, value: Value) -> Next
    func eraseToAnyMutableSearchTree() -> AnyMutableSearchTree<ID, Value>
}

extension MutableSearchTree {

    public func eraseToAnyMutableSearchTree() -> AnyMutableSearchTree<ID, Value> {
        return AnyMutableSearchTree(self)
    }

}

