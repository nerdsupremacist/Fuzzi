
import Foundation

protocol InternalLeafSearchable: InternalSearchable {
    var components: Set<String> { get }
}

extension InternalLeafSearchable {

    func components(includeAll: Bool) -> Set<String> {
        return components
    }

}
