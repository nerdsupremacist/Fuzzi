
import Foundation

public struct EmptySearchable: Searchable, InternalLeafSearchable {
    let components: Set<String> = []

    public init() { }
    
    public var body: Never {
        fatalError("Body Not Implemented")
    }
}
