//
//  PokeModelTests.swift
//  iOSBootcampChallengeTests
//
//  Created by Jorge Benavides on 10/11/21.
//

import XCTest

@testable
import iOSBootcampChallenge

class PokeModelTests: XCTestCase {

    var pokeModel: PokeModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        pokeModel = PokeModel(api: PokeAPI.shared)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        pokeModel = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // Create an expectation

        var pokemons: [Pokemon] = []
        let count = 30

        let expectation = self.expectation(description: "Suitable refresh time")

        self.pokeModel.getListOfPokemons(limit: count, completion: {
            pokemons = $0
            expectation.fulfill()
        })

        // Wait for the expectation to be fullfilled, or time out
        // after 5 seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(pokemons.count, count, "is not working")
    }
}
