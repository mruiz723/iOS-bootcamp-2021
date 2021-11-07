//
<<<<<<< HEAD
//  IOSBootcampChallengeUITests.swift
=======
//  iOS_Bootcamp_ChallengeUITests.swift
>>>>>>> 7b2e15b (Swift lint, access control  and Pokemon model (#1))
//  iOS Bootcamp ChallengeUITests
//
//  Created by Jorge Benavides on 26/09/21.
//

import XCTest

class IOSBootcampChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

<<<<<<< HEAD
        // In UI tests it’s important to set the initial state -
        // such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
=======
<<<<<<<< HEAD:iOS Bootcamp ChallengeUITests/IOSBootcampChallengeUITests.swift
        // In UI tests it’s important to set the initial state -
        // such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
========
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run.
        // The setUp method is a good place to do this.
>>>>>>>> 7b2e15b (Swift lint, access control  and Pokemon model (#1)):iOS Bootcamp ChallengeUITests/iOS_Bootcamp_ChallengeUITests.swift
>>>>>>> 7b2e15b (Swift lint, access control  and Pokemon model (#1))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
