
import Foundation

extension Optional: Searchable where Wrapped: Searchable {

    public var body: some Searchable {
        switch self {
        case .some(let searchable):
            return searchable.eraseToAnySearchable()
        case .none:
            return EmptySearchable().eraseToAnySearchable()
        }
    }

}
