
import Foundation

public struct TupleSearchable<T>: Searchable, InternalSearchable {
    let values: [AnySearchable]

    public var body: Never {
        fatalError("Body not implemented")
    }

    func components(includeAll: Bool) -> [String : Double] {
        return values.reduce([:]) { accumulator, searchable in
            accumulator.merging(searchable.components(includeAll: includeAll)) { $0 + $1 }
        }
    }
}
