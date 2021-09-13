
import Foundation

public protocol Searchable {
    associatedtype Body: Searchable

    @SearchableBuilder
    var body: Body { get }
}
