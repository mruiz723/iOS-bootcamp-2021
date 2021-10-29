//: [L](@previous)

import Foundation

//    Interface Segregation Principle
//    A client should never be forced to implement an interface that it doesn’t use,
//    or clients shouldn’t be forced to depend on methods they do not use.

protocol Cacheable {
    func retrieveAccessToken()
}

protocol UserProtocol: Cacheable {
    func retreiveUserID()
}

protocol FetchNewsProtocol {
    var accessToken: Cacheable { get set }
    func getNews()
}
struct FetchNews: FetchNewsProtocol {
    var accessToken: Cacheable

    func getNews() {
        // Use the accessToken to retrieve the news
    }
}


protocol FetchProfileProtocol {
    var userID: UserProtocol { get set }
    func getProfile()
}
struct FetchProfile: FetchProfileProtocol {
    var userID: UserProtocol
    
    func getProfile() {
        // Use the userID to retreive the profile
    }
}

//: [D](@next)
