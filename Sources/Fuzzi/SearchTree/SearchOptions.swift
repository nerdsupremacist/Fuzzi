
import Foundation

public struct SearchOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension SearchOptions {
    public static let sortByScore = SearchOptions(rawValue: 1 << 0)
    public static let caseInsensitive = SearchOptions(rawValue: 1 << 1)

    public static let standard: SearchOptions = [.sortByScore, .caseInsensitive]
}
