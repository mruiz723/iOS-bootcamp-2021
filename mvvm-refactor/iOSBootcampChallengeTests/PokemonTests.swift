//
//  PokemonTests.swift
//  iOSBootcampChallengeTests
//
//  Created by Jorge Benavides on 10/11/21.
//

import XCTest

@testable
import iOSBootcampChallenge

class PokemonTests: XCTestCase {

    var pokemon: Pokemon!

    let decoder = JSONDecoder()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let filepath = Bundle(for: self.classForCoder).path(forResource: "pokemon_raw", ofType: "json")!
        let json: String = try String(contentsOfFile: filepath)
        let data = Data(json.utf8)
        pokemon = try self.decoder.decode(Pokemon.self, from: data)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        pokemon = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        let options = XCTMeasureOptions.default
        options.iterationCount = 10

        var string: String!

        self.measure(options: options) {
            string = pokemon.formattedNumber()
        }
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(string, "#132", "inccorrect number format")
    }

}
