
import Foundation

extension Searchable {

    public func enablePrefixes(minimumPrefixSize: Int = 3) -> some Searchable {
        return includeComponents(includeOriginal: true) { word in
            word.prefixes(minimumSize: minimumPrefixSize)
        }
    }

}

extension String {

    fileprivate func prefixes(minimumSize: Int) -> Set<String> {
        guard count >= minimumSize else { return [] }
        let range = minimumSize...count
        let prefixes = range.map { String(self[..<index(startIndex, offsetBy: $0)]) }
        return Set(prefixes)
    }

}
