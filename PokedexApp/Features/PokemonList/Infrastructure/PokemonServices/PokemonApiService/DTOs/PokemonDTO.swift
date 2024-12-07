//
//  PokemonDTO.swift
//  PokedexApp
//
//  Created by Luis Chavez pozo on 5/12/24.
//
import Foundation

struct PokemonDTO: Decodable {
    let id: Int
    let name: String
    let url: URL

    func toModel() -> Pokemon {
        Pokemon(id: id, name: name)
    }
}

extension PokemonDTO {
    private enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(URL.self, forKey: .url)

        guard let extractedID = PokemonDTO.extractPokemonID(from: url) else {
            throw DecodingError.dataCorruptedError(forKey: .url, in: container, debugDescription: "Invalid URL: \(url)")
        }
        id = extractedID
    }

    fileprivate static func extractPokemonID(from url: URL) -> Int? {
        let components = url.path.split(separator: "/")
        guard let lastComponent = components.last, let id = Int(lastComponent) else {
            return nil
        }
        return id
    }
}


