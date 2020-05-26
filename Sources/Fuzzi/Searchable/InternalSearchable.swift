
import Foundation

protocol InternalSearchable {
    func components(includeAll: Bool) -> Set<String>
}
