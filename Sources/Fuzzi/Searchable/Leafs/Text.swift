
import Foundation

extension String {

    public func searchText() -> some Searchable {
        return Text(self)
    }

}

public struct Text: Searchable, InternalLeafSearchable {
    let components: [String : Double]

    public init(_ string: String) {
        self.components = [string : 1]
    }

    public var body: Never {
        fatalError("Body not implemented")
    }
}
