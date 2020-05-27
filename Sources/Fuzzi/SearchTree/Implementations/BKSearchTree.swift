
import Foundation

struct BKSearchTree<ID: Hashable, Value: Searchable>: MutableSearchTree {
    typealias Next = BKSearchTree<ID, Value>

    let component: String
    var values: [(ID, Double)]
    var children: [Int : BKSearchTree<ID, Value>]
}

extension BKSearchTree {

    init(component: String) {
        self.init(component: component, values: [], children: [:])
    }

    private mutating func append(id: ID, for component: String, weight: Double) {
        guard component != self.component else {
            return values.append((id, weight))
        }
        let distance = self.component.distance(to: component)
        children[distance, default: .init(component: component)].append(id: id, for: component, weight: weight)
    }

    mutating func append(id: ID, value: Value) {
        components(for: value).forEach { append(id: id, for: $0.key, weight: $0.value) }
    }

    func appending(id: ID, value: Value) -> BKSearchTree<ID, Value> {
        var tree = self
        tree.append(id: id, value: value)
        return tree
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
            values.forEach { value in
                let (value, weight) = value
                let occurence = Occurence(component: component, coefficient: coefficient * weight)
                accumulator[value, default: .init(value: value)].append(occurence)
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

    func search(query: String,
                       maxDistance: Int,
                       relevantAfter: Double,
                       options: SearchOptions) -> [SearchResult<ID>] {

        guard !options.contains(.sortByScore) else {

            return search(query: query,
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
