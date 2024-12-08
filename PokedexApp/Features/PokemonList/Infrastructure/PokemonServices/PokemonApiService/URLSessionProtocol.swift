//
//  URLSessionProtocol.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 6/12/24.
//

import Foundation


protocol URLSessionProtocol: Sendable {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return try await self.data(from: url, delegate: nil)
    }
}
