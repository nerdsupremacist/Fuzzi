
import Foundation

extension Searchable {

    public func weighted(scale: Double) -> some Searchable {
        return Weighted(content: self, factor: .scale(scale))
    }

    public func overrideWeigths(to weight: Double) -> some Searchable {
        return Weighted(content: self, factor: .override(weight))
    }

}

private enum WeightFactor {
    case scale(Double)
    case override(Double)

    func change(weight: Double) -> Double {
        switch self {
        case .scale(let scale):
            return weight * scale
        case .override(let weight):
            return weight
        }
    }
}

private struct Weighted<Content: Searchable>: Searchable, InternalSearchable {
    let content: Content
    let factor: WeightFactor

    var body: Never {
        fatalError("Body not implemented")
    }

    func components(includeAll: Bool) -> [String : Double] {
        return Fuzzi.components(for: content, includeAll: includeAll).mapValues(factor.change(weight:))
    }
}
