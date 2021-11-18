//
//  PokeAPI.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import Foundation
import Combine

class PokeAPI {

    static let shared = PokeAPI()
    static let baseURL = "https://pokeapi.co/api/v2"

    @discardableResult
    func get<T: Decodable>(url: String) -> Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, Data>, T, JSONDecoder>? {
        let path = url.replacingOccurrences(of: PokeAPI.baseURL, with: "")
        let publisher = URLSession.shared.dataTaskPublisher(with: PokeAPI.baseURL + path)?
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
        return publisher
    }

}

extension URLSession {

    func dataTaskPublisher(with url: String) -> URLSession.DataTaskPublisher? {
        guard let url = URL(string: url) else { return nil }
        return self.dataTaskPublisher(with: url)
    }

    func dataTaskPublisher(with url: URL) -> URLSession.DataTaskPublisher {
        return self.dataTaskPublisher(for: URLRequest(url: url))
    }

}
