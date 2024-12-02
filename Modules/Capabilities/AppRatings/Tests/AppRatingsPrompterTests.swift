//  Created by Geoff Pado on 7/29/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Defaults
import Editing
import LoggingDoubles
import TestHelpers
import XCTest

@testable import AppRatings
@testable import Logging

class AppRatingsPrompterTests: XCTestCase {
    func testDisplayingPromptOnFirstAttemptDoesNotPrompt() async throws {
        Defaults.numberOfSaves = 1
        let promptExpectation = expectation(description: "prompted")
        promptExpectation.isInverted = true
        let prompter = AppRatingsPrompter(logger: SpyLogger()) { _ in
            promptExpectation.fulfill()
        }

        let windowScene = try InstanceHelper.create(UIWindowScene.self)
        await prompter.displayRatingsPrompt(in: windowScene)

        await fulfillment(of: [promptExpectation], timeout: 0.01)
    }

    func testDisplayingPromptOnThirdAttemptPrompts() async throws {
        Defaults.numberOfSaves = 3
        let promptExpectation = expectation(description: "prompted")
        let prompter = AppRatingsPrompter(logger: SpyLogger()) { _ in
            promptExpectation.fulfill()
        }

        let windowScene = try InstanceHelper.create(UIWindowScene.self)
        await prompter.displayRatingsPrompt(in: windowScene)

        await fulfillment(of: [promptExpectation], timeout: 1)
    }

    func testDisplayingPromptOnFifthAttemptDoesNotPrompt() async throws {
        Defaults.numberOfSaves = 5
        let promptExpectation = expectation(description: "prompted")
        promptExpectation.isInverted = true
        let prompter = AppRatingsPrompter(logger: SpyLogger()) { _ in
            promptExpectation.fulfill()
        }

        let windowScene = try InstanceHelper.create(UIWindowScene.self)
        await prompter.displayRatingsPrompt(in: windowScene)

        await fulfillment(of: [promptExpectation], timeout: 0.01)
    }

    func testDisplayingPromptOnSixthAttemptPrompts() async throws {
        Defaults.numberOfSaves = 6
        let promptExpectation = expectation(description: "prompted")
        let prompter = AppRatingsPrompter(logger: SpyLogger()) { _ in
            promptExpectation.fulfill()
        }

        let windowScene = try InstanceHelper.create(UIWindowScene.self)
        await prompter.displayRatingsPrompt(in: windowScene)

        await fulfillment(of: [promptExpectation], timeout: 1)
    }

    func testDisplayingPromptWithNoWindowSceneLogsError() async throws {
        let spy = SpyLogger()
        let prompter = AppRatingsPrompter(logger: spy) { _ in }

        await prompter.displayRatingsPrompt(in: nil)

        let event = try XCTUnwrap(spy.loggedEvents.first)
        XCTAssertEqual(event.value, "TelemetryDeck.Error.occurred")
        XCTAssertEqual(event.info["TelemetryDeck.Error.id"], "missingWindowScene")
    }

    func testDisplayingPromptLogsEvent() async throws {
        Defaults.numberOfSaves = 999
        let spy = SpyLogger()
        let prompter = AppRatingsPrompter(logger: spy) { _ in }
        let windowScene = try InstanceHelper.create(UIWindowScene.self)

        await prompter.displayRatingsPrompt(in: windowScene)

        let event = try XCTUnwrap(spy.loggedEvents.first)
        XCTAssertEqual(event.value, "AppRatingsPrompter.requestedRating")
    }
}
