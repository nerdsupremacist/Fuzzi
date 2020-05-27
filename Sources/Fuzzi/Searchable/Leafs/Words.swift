
import Foundation

extension String {

    public func searchWords() -> some Searchable {
        return Words(self)
    }

}

public struct Words: Searchable, InternalLeafSearchable {
    let components: [String : Double]

    public init(_ string: String) {
        let characterSet = CharacterSet.alphanumerics.inverted.union(.whitespacesAndNewlines)
        self.components = Dictionary(string.components(separatedBy: characterSet).filter { !$0.isEmpty }.map { ($0, 1) }) { $0 + $1 }
    }

    public var body: Never {
        fatalError("Body not implemented")
    }
}
