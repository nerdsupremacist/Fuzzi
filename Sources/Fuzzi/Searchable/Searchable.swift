
import Foundation

public protocol Searchable {
    associatedtype Body: Searchable
    var body: Body { get }
}
