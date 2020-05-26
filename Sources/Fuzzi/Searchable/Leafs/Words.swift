
import Foundation

extension String {

    public func searchWords() -> some Searchable {
        return Words(self)
    }

}

public struct Words: Searchable, InternalLeafSearchable {
    let components: Set<String>

    public init(_ string: String) {
        let characterSet = CharacterSet.alphanumerics.inverted.union(.whitespacesAndNewlines)
        self.components = Set(string.components(separatedBy: characterSet).filter { !$0.isEmpty })
    }

    public var body: Never {
        fatalError("Body not implemented")
    }
}
