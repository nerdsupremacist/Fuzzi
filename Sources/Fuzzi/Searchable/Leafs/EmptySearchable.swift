
import Foundation

public struct EmptySearchable: Searchable, InternalLeafSearchable {
    let components: [String : Double] = [:]

    public init() { }
    
    public var body: Never {
        fatalError("Body Not Implemented")
    }
}
