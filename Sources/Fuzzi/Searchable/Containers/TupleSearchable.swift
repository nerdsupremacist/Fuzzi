
import Foundation

public struct TupleSearchable<T>: Searchable, InternalSearchable {
    let values: [AnySearchable]

    public var body: Never {
        fatalError("Body not implemented")
    }

    func components(includeAll: Bool) -> Set<String> {
        return values.reduce([]) { $0.union($1.components(includeAll: includeAll)) }
    }
}
