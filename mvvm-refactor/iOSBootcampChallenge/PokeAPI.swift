//
//  PokeAPI.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import Foundation

class PokeAPI {

    static let shared = PokeAPI()
    static let baseURL = "https://pokeapi.co/api/v2/"

    @discardableResult
    func get<T: Decodable>(url: String, onCompletion: @escaping(T?, Error?) -> Void) -> URLSessionDataTask? {
        let path = url.replacingOccurrences(of: PokeAPI.baseURL, with: "")
        let task = URLSession.shared.dataTask(with: PokeAPI.baseURL + path, completionHandler: { data, _, error in
            guard let data = data else {
                onCompletion(nil, error)
                return
            }
            do {
                let entity = try JSONDecoder().decode(T.self, from: data)
                onCompletion(entity, error)
            } catch {
                onCompletion(nil, error)
            }
        })
        task?.resume()
        return task
    }

}

extension URLSession {

    func dataTask(with url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: url) else { return nil }
        return self.dataTask(with: URLRequest(url: url), completionHandler: completionHandler)
    }

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: URLRequest(url: url), completionHandler: completionHandler)
    }

}
