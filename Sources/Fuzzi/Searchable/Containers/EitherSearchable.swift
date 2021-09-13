
import Foundation

public struct EitherSearchable<A: Searchable, B: Searchable>: Searchable {
    public typealias Body = Never

    private enum Storage {
        case first(A)
        case second(B)
    }

    private let storage: Storage

    public var body: Never {
        fatalError()
    }

    init(first: A) {
        storage = .first(first)
    }

    init(second: B) {
        storage = .second(second)
    }
}

extension EitherSearchable: InternalSearchable {

    func components(includeAll: Bool) -> [String : Double] {
        switch storage {
        case .first(let searchable):
            return Fuzzi.components(for: searchable, includeAll: includeAll)
        case .second(let searchable):
            return Fuzzi.components(for: searchable, includeAll: includeAll)
        }
    }

}
