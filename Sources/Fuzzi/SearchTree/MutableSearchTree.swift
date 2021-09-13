
import Foundation

public protocol MutableSearchTree: SearchTree {
    associatedtype Next: MutableSearchTree where Next.ID == ID

    func appending(id: ID, components: [String : Double]) -> Next
    func eraseToAnyMutableSearchTree() -> AnyMutableSearchTree<ID>
}

extension MutableSearchTree {

    public func eraseToAnyMutableSearchTree() -> AnyMutableSearchTree<ID> {
        return AnyMutableSearchTree(self)
    }

}

