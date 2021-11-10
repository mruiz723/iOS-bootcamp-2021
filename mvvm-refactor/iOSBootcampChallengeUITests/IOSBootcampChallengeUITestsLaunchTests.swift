//
//  IOSBootcampChallengeUITestsLaunchTests.swift
//  iOS Bootcamp ChallengeUITests
//
//  Created by Jorge Benavides on 26/09/21.
//

import XCTest

class IOSBootcampChallengeUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app
        app.navigationBars["Pokédex"].searchFields["Search a pokemon"].tap()

        if app.navigationBars["Pokédex"].searchFields["Search a pokemon"].buttons["Clear text"].exists {
            app.navigationBars["Pokédex"].searchFields["Search a pokemon"].buttons["Clear text"].tap()
        }

        app.keys["P"].tap()
        app.keys["i"].tap()
        app.keys["k"].tap()
        app.keys["a"].tap()

        app.collectionViews.cells.otherElements.containing(.staticText, identifier: " Electric ").element.tap()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
        app.terminate()
    }
}
