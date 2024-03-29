
import Foundation

struct BKSearchTree<ID: Hashable>: MutableSearchTree {
    typealias Next = BKSearchTree<ID>

    struct ValueEntry {
        let value: ID
        let weight: Double
    }

    let component: String
    var values: [ValueEntry]
    var children: [Int : BKSearchTree<ID>]
}

extension BKSearchTree {

    init(component: String) {
        self.init(component: component, values: [], children: [:])
    }

    private mutating func append(id: ID, for component: String, weight: Double) {
        guard component != self.component else {
            return values.append(ValueEntry(value: id, weight: weight))
        }
        let distance = self.component.distance(to: component)
        children[distance, default: .init(component: component)].append(id: id, for: component, weight: weight)
    }

    func appending(id: ID, components: [String : Double]) -> BKSearchTree<ID> {
        var tree = self
        tree.append(id: id, components: components)
        return tree
    }

    mutating func append(id: ID, components: [String : Double]) {
        components.forEach { append(id: id, for: $0.key, weight: $0.value) }
    }

    func searchWord(accumulator: [ID : SearchResult<ID>],
                    query: String,
                    maxDistance: Int,
                    relevantAfter: Double,
                    options: SearchOptions) -> [ID : SearchResult<ID>] {

        var accumulator = accumulator

        let currentDistance = component.distance(to: query)
        let upperAllowed = currentDistance + maxDistance
        let lowerAllowed = max(0, currentDistance - maxDistance)


        let coefficient = Search.coefficient(value: query, using: component, options: options)

        if currentDistance <= maxDistance, coefficient >= relevantAfter {
            values.forEach { entry in
                let occurence = Occurence(component: component, coefficient: coefficient * entry.weight)
                accumulator[entry.value, default: .init(value: entry.value)].append(occurence)
            }
        }

        let range = (lowerAllowed...upperAllowed)
        let children = range.compactMap { self.children[$0] }
        return children.reduce(accumulator) { $1.searchWord(accumulator: $0,
                                                            query: query,
                                                            maxDistance: maxDistance,
                                                            relevantAfter: relevantAfter,
                                                            options: options) }
    }

    func performSearch(query: String,
                       maxDistance: Int,
                       relevantAfter: Double,
                       options: SearchOptions) -> [SearchResult<ID>] {

        guard !options.contains(.sortByScore) else {
            return performSearch(query: query,
                                 maxDistance: maxDistance,
                                 relevantAfter: relevantAfter,
                                 options: options.subtracting(.sortByScore)).sorted { $0.score >= $1.score }
        }

        let dictionary = query.components(separatedBy: " ").reduce([:]) { dict, word in
            return searchWord(accumulator: dict,
                              query: word,
                              maxDistance: maxDistance,
                              relevantAfter: relevantAfter,
                              options: options)
        }
        return Array(dictionary.values)
    }

}

extension BKSearchTree.ValueEntry: Encodable where ID: Encodable { }

extension BKSearchTree.ValueEntry: Decodable where ID: Decodable { }

extension BKSearchTree: Encodable where ID: Encodable { }

extension BKSearchTree: Decodable where ID: Decodable { }
