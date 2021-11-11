//
//  PokeAPI.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import Foundation

enum NetworkingError: Error {
    case invalidURL
    case unknown(error: Error?)
}

class PokeAPI {

    static let baseURL = "https://pokeapi.co/api/v2/"
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func get<T: Decodable>(urlPath: String,
                           onCompletion: @escaping(Result<T, NetworkingError>) -> Void) {
        let path = urlPath.replacingOccurrences(of: PokeAPI.baseURL, with: "")

        guard let url = URL(string: PokeAPI.baseURL + path) else {
            onCompletion(.failure(.invalidURL))
            return
        }

        session.loadData(from: url) { data, error in
            guard let data = data else {
                onCompletion(.failure(.unknown(error: error)))
                return
            }
            do {
                let entity = try JSONDecoder().decode(T.self, from: data)
                onCompletion(.success(entity))
            } catch {
                onCompletion(.failure(.unknown(error: error)))
            }
        }
    }
}

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?

    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}
