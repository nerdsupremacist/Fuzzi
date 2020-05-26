
import Foundation

public struct CompoundSearchable<Content: Searchable>: Searchable {
    private let content: Content

    public init(@SearchableBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some Searchable {
        content
    }
}
