//
//  URLSessionSpy.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 6/12/24.
//

import Foundation
@testable import PokedexApp

class URLSessionSpy: URLSessionProtocol, @unchecked Sendable {
    var invokedData = false
    var invokedDataCount = 0
    var invokedDataParameters: (url: URL, Void)?
    var invokedDataParametersList = [(url: URL, Void)]()
    var stubbedDataError: Error?
    var stubbedDataResult: (Data, URLResponse)!

    func data(from url: URL) async throws -> (Data, URLResponse) {
        invokedData = true
        invokedDataCount += 1
        invokedDataParameters = (url, ())
        invokedDataParametersList.append((url, ()))
        if let error = stubbedDataError {
            throw error
        }
        return stubbedDataResult
    }
}
