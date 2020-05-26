
import Foundation

extension Never: Searchable {
    public typealias Body = Never

    public var body: Never {
        fatalError("Body is not implemented")
    }
}
