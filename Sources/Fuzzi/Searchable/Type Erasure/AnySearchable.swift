
import Foundation

public struct AnySearchable: Searchable, InternalSearchable {
    private let _components: (Bool) -> [String : Double]

    public init<S : Searchable>(_ searchable: S) {
        _components = { Fuzzi.components(for: searchable, includeAll: $0) }
    }

    public var body: Never {
        fatalError("Body not implemented")
    }

    func components(includeAll: Bool) -> [String : Double] {
        return _components(includeAll)
    }
}


extension Searchable {

    public func eraseToAnySearchable() -> AnySearchable {
        return AnySearchable(self)
    }

}
