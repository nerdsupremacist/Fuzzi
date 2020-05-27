
import Foundation

protocol InternalSearchable {
    func components(includeAll: Bool) -> [String : Double]
}
