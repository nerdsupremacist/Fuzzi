
import Foundation

extension Array: Searchable where Element: Searchable {

    public var body: Never {
        fatalError("Body Not Implemented")
    }

}

extension Array: InternalSearchable where Element: Searchable {

    func components(includeAll: Bool) -> [String : Double] {
        return reduce([:]) { accumulator, searchable in
            accumulator.merging(Fuzzi.components(for: searchable, includeAll: includeAll)) { $0 + $1 }
        }
    }

}
