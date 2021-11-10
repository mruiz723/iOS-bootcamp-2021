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

        let expected = Pokemon(id: 132,
                               name: "ditto",
                               image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png",
                               types: ["normal"],
                               abilities: ["Limber", "Imposter"],
                               weight: 40.0,
                               baseExperience: 101)
        let notExpected = Pokemon(id: 1,
                               name: "bulbasaur",
                               image: "",
                               types: [],
                               abilities: [],
                               weight: 30,
                               baseExperience: 3)

        let filepath = Bundle(for: self.classForCoder).path(forResource: "pokemon_raw", ofType: "json")!
        let json: String = try String(contentsOfFile: filepath)
        let data = Data(json.utf8)
        pokemon = try self.decoder.decode(Pokemon.self, from: data)

        XCTAssertEqual(pokemon, expected)
        XCTAssertNotEqual(pokemon, notExpected)
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
