//
//  Sequence+Ext.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 9/12/24.
//

extension Sequence {
    func asyncMap<T: Sendable>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var results = [T]()
        for element in self {
            try await results.append(transform(element))
        }
        return results
    }
}
