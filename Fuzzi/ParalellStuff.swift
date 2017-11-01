//
//  ParalellStuff.swift
//  Fuzzi
//
//  Created by Mathias Quintero on 11/1/17.
//

import Foundation

class ParallelResult<Value> {
    
    private(set) var value: Value?
    private var group: DispatchGroup
    
    init(group: DispatchGroup, setterHandler: (ParallelResult<Value>) -> Void) {
        self.group = group
        group.enter()
        setterHandler(self)
    }
    
    static func byAppliying(to group: DispatchGroup, value: @autoclosure @escaping () -> Value) -> ParallelResult<Value> {
        return .init(group: group) { result in
            DispatchQueue.global().async {
                result.fullfill(with: value())
            }
        }
    }
    
    func fullfill(with value: Value) {
        self.value = value
        group.leave()
    }
    
}

extension Sequence {
    
    func parallelMap<Value>(_ transform: @escaping (Element) -> Value) -> [Value] {
        
        let group = DispatchGroup()
        let results: [ParallelResult<Value>] = map { element in
            return .byAppliying(to: group, value: transform(element))
        }
        group.wait()
        return results.flatMap { $0.value }
    }
    
    func parallelFlatMap<SubSequence: Sequence>(_ transform: @escaping (Element) -> SubSequence) -> [SubSequence.Element] {
        return parallelMap(transform).flatMap { $0 }
    }
    
    func parallelFilter(_ isIncluded: @escaping (Element) -> Bool) -> [Element] {
        return self.parallelMap { ($0, isIncluded($0)) }
                   .filter { $0.1 }
                   .parallelMap { $0.0 }
    }
    
}
