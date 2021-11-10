//
//  DetailViewTests.swift
//  iOSBootcampChallengeUITests
//
//  Created by Jorge Benavides on 10/11/21.
//

import XCTest

@testable
import iOSBootcampChallenge

class DetailViewTests: XCTestCase {

    func testExample() throws {
        let filepath = Bundle(for: self.classForCoder).path(forResource: "pokemon_raw", ofType: "json")!
        let json: String = try String(contentsOfFile: filepath)

        let data = Data(json.utf8)

        let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        let viewModel = DetailViewModel(pokemon: pokemon)
        let detailView = DetailView(viewModel: viewModel, container: view)

        XCTAssertNotNil(detailView.body)
        XCTAssertEqual(detailView.idLabel.text, "#132")
    }

}
