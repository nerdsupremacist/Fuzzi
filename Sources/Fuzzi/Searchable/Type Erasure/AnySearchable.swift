
import Foundation

public struct AnySearchable: Searchable, InternalSearchable {
    private let _components: (Bool) -> Set<String>

    public init<S : Searchable>(_ searchable: S) {
        _components = { Fuzzi.components(for: searchable, includeAll: $0) }
    }

    public var body: Never {
        fatalError("Body not implemented")
    }

    func components(includeAll: Bool) -> Set<String> {
        return _components(includeAll)
    }
}


extension Searchable {

    func eraseToAnySearchable() -> AnySearchable {
        return AnySearchable(self)
    }

}
