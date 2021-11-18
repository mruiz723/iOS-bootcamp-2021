//
//  PokeAPI.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import Foundation
import RxSwift

class PokeAPI {

    static let baseURL = "https://pokeapi.co/api/v2/"
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared.rx) {
        self.session = session
    }

    func get<T: Decodable>(urlPath: String) -> Observable<T> {
        let urlString = PokeAPI.baseURL + urlPath
        return session.loadData(from: urlString)
            .map { result in
                try JSONDecoder().decode(T.self, from: result.data)
            }
            .observe(on: MainScheduler.asyncInstance)
    }
}
