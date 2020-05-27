
import Foundation

extension Searchable {

    public func includeComponents(includeOriginal: Bool = false,
                                  _ transform: @escaping (String) -> Set<String>) -> some Searchable {

        return ComponentsMapper(content: self, includeOriginal: includeOriginal, transform: transform)
    }

}

private struct ComponentsMapper<Content: Searchable>: Searchable, InternalSearchable {
    let content: Content
    let includeOriginal: Bool
    let transform: (String) -> Set<String>

    var body: Never {
        fatalError("Body not implemented")
    }

    func components(includeAll: Bool) -> [String : Double] {
        let components = Fuzzi.components(for: content, includeAll: false)

        if includeAll {
            let addititonal = components.flatMapKeys(transform) { $0 + $1 }
            if includeOriginal {
                return Fuzzi.components(for: content, includeAll: true).merging(addititonal) { max($0, $1) }
            } else {
                return addititonal
            }
        }

        return components
    }
}

extension Dictionary {

    public func flatMapKeys<SegmentOfResult : Sequence>(_ transform: (Key) throws -> SegmentOfResult,
                                                        _ combine: (Value, Value) -> Value) rethrows -> [SegmentOfResult.Element : Value] {

        var dictionay: [SegmentOfResult.Element : Value] = [:]
        for (key, value) in self {
            for newKey in try transform(key) {
                if let previousValue = dictionay[newKey] {
                    dictionay[newKey] = combine(previousValue, value)
                } else {
                    dictionay[newKey] = value
                }
            }
        }
        return dictionay
    }

}
