
import Foundation

extension Searchable {

    public func enableInfixes(minimumSize: Int = 3) -> some Searchable {
        return includeComponents(includeOriginal: true) { word in
            word.infixes(minimumSize: minimumSize)
        }
    }

}

extension String {

    fileprivate func infixes(minimumSize: Int) -> Set<String> {
        guard count >= minimumSize else { return [] }
        let sizeRange = minimumSize...count
        let infixes = sizeRange.flatMap { size -> [String] in
            let startRange = 0...(count - size)
            return startRange.map { start -> String in
                let startIndex = index(self.startIndex, offsetBy: start)
                let endIndex = index(startIndex, offsetBy: size)
                return String(self[startIndex..<endIndex])
            }
        }
        return Set(infixes)
    }

}
