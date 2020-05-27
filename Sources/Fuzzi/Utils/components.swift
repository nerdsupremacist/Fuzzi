
import Foundation

func components<S : Searchable>(for searchable: S, includeAll: Bool = true) -> [String : Double] {
    if S.Body.self == Never.self {
        switch searchable {
        case let searchable as InternalLeafSearchable:
            return searchable.components
        case let searchable as InternalSearchable:
            return searchable.components(includeAll: includeAll)
        default:
            fatalError()
        }
    }

    return components(for: searchable.body, includeAll: includeAll)
}
