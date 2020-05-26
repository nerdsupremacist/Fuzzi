
import Foundation

extension Searchable {

    public func enablePostfixes(minimumPostfixSize: Int = 3) -> some Searchable {
        includeComponents(includeOriginal: true) { word in
            word.postfixes(minimumSize: minimumPostfixSize)
        }
    }

}

extension String {

    fileprivate func postfixes(minimumSize: Int) -> Set<String> {
        guard count >= minimumSize else { return [] }
        let range = 0..<(count - minimumSize)
        let prefixes = range.map { String(self[index(startIndex, offsetBy: $0)...]) }
        return Set(prefixes)
    }

}
