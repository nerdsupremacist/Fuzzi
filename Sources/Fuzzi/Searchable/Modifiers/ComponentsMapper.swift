
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

    func components(includeAll: Bool) -> Set<String> {
        let words = Fuzzi.components(for: content, includeAll: false)

        if includeAll {
            let addititonal = words.flatMap(transform)
            if includeOriginal {
                return Fuzzi.components(for: content, includeAll: true).union(addititonal)
            } else {
                return Set(addititonal)
            }
        }

        return words
    }
}
