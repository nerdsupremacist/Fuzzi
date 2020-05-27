
import Foundation

protocol InternalLeafSearchable: InternalSearchable {
    var components: [String : Double] { get }
}

extension InternalLeafSearchable {

    func components(includeAll: Bool) -> [String : Double] {
        return components
    }

}
