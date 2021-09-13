
import Foundation

public struct StandardSearchTree<ID : Hashable>: MutableSearchTree {
    enum Storage {
        case empty
        case some(BKSearchTree<ID>)
    }

    private let storage: Storage

    init() {
        storage = .empty
    }

    private init(tree: BKSearchTree<ID>) {
        storage = .some(tree)
    }

    public func performSearch(query: String, maxDistance: Int, relevantAfter: Double, options: SearchOptions) -> [SearchResult<ID>] {
        switch storage {
        case .empty:
            return []
        case .some(let tree):
            return tree.performSearch(query: query, maxDistance: maxDistance, relevantAfter: relevantAfter, options: options)
        }
    }

    public func appending(id: ID, components: [String : Double]) -> StandardSearchTree<ID> {
        switch storage {
        case .empty:
            guard let component = components.first?.key else { return self }
            var tree = BKSearchTree<ID>(component: component)
            tree.append(id: id, components: components)
            return StandardSearchTree(tree: tree)
        case .some(let tree):
            return StandardSearchTree(tree: tree.appending(id: id, components: components))
        }
    }
}

extension StandardSearchTree {

    enum StorageKind: String, Codable {
        case empty
        case some
    }

    enum CodingKeys: String, CodingKey {
        case kind
        case tree
    }

}

extension StandardSearchTree: Encodable where ID: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch storage {
        case .empty:
            try container.encode(StorageKind.empty, forKey: .kind)
        case .some(let tree):
            try container.encode(StorageKind.some, forKey: .kind)
            try container.encode(tree, forKey: .tree)
        }
    }

}

extension StandardSearchTree: Decodable where ID: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try container.decode(StorageKind.self, forKey: .kind)
        switch kind {
        case .empty:
            self.init()
        case .some:
            self.init(tree: try container.decode(BKSearchTree<ID>.self, forKey: .tree))
        }
    }

}
