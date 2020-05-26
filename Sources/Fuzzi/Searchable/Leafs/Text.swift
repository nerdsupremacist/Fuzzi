
import Foundation

extension String {

    public func searchText() -> some Searchable {
        return Text(self)
    }

}

public struct Text: Searchable, InternalLeafSearchable {
    let components: Set<String>

    public init(_ string: String) {
        self.components = [string]
    }

    public var body: Never {
        fatalError("Body not implemented")
    }
}
