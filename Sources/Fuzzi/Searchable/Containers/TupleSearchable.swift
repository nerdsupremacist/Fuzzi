
import Foundation

public struct TupleSearchable<T>: Searchable {
    let values: [AnySearchable]

    public var body: some Searchable {
        values
    }
}
