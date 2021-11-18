//
//  Networking.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import UIKit
import RxSwift
import RxCocoa

enum NetworkingError: Error {
    case invalidURL
    /// Unknown error occurred.
    case unknown(error: Error?)
    /// Response is not NSHTTPURLResponse
    case nonHTTPResponse(response: URLResponse)
    /// Response is not successful. (not in `200 ..< 300` range)
    case httpRequestFailed(response: HTTPURLResponse, data: Data?)
    /// Deserialization error.
    case deserializationError(error: Swift.Error)
}

extension NetworkingError: CustomDebugStringConvertible {
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .unknown:
            return "Unknown error has occurred."
        case let .nonHTTPResponse(response):
            return "Response is not NSHTTPURLResponse `\(response)`."
        case let .httpRequestFailed(response, _):
            return "HTTP request failed with `\(response.statusCode)`."
        case let .deserializationError(error):
            return "Error during deserialization of the response: \(error)"
        }
    }
}

protocol NetworkSession {
    func loadData(from urlString: String) -> Observable<(data: Data, response: HTTPURLResponse)>
}

extension Reactive: NetworkSession where Base: URLSession {
    func loadData(from urlString: String) -> Observable<(data: Data, response: HTTPURLResponse)> {
        return Observable.create { observer in
            guard let url = URL(string: urlString) else {
                observer.on(.error(NetworkingError.invalidURL))
                return Disposables.create()
            }
            let task = self.base.dataTask(with: url) { (data, response, error) in
                guard let response = response, let data = data else {
                    observer.on(.error(error ?? NetworkingError.unknown(error: nil)))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.on(.error(NetworkingError.nonHTTPResponse(response: response)))
                    return
                }

                observer.on(.next((data, httpResponse)))
                observer.on(.completed)
            }

            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }

    /*
     An example provided by RxSwift
    func response(request: URLRequest) -> Observable<(Data, HTTPURLResponse)> {
        return Observable.create { observer in
            let task = self.base.dataTask(with: request) { (data, response, error) in

                guard let response = response, let data = data else {
                    observer.on(.error(error ?? NetworkingError.unknown(error: nil)))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.on(.error(NetworkingError.nonHTTPResponse(response: response)))
                    return
                }

                observer.on(.next((data, httpResponse)))
                observer.on(.completed)
            }

            task.resume()

            return Disposables.create(with: task.cancel)
        }
    }
     */
}
