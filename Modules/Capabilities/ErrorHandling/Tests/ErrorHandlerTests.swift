//  Created by Geoff Pado on 5/5/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import LoggingDoubles
import XCTest

@testable import ErrorHandling
@testable import Logging

final class ErrorHandlerTests: XCTestCase {
    func testLoggingSwiftErrorLogsDescription() throws {
        let logger = SpyLogger()
        let handler = ErrorHandler(logger: logger)

        handler.log(SampleError.sample)
        let event = try XCTUnwrap(logger.loggedEvents.first)

        XCTAssertEqual(event.value, "TelemetryDeck.Error.occurred")
        XCTAssertEqual(event.info["TelemetryDeck.Error.id"], "sample")
    }

    func testLoggingNSErrorLogsInformation() throws {
        let logger = SpyLogger()
        let handler = ErrorHandler(logger: logger)
        let error = NSError(domain: "sample", code: 19)

        handler.log(error)
        let event = try XCTUnwrap(logger.loggedEvents.first)

        XCTAssertEqual(event.value, "TelemetryDeck.Error.occurred")
        XCTAssertEqual(event.info, [
            "TelemetryDeck.Error.id": "sample - 19",
            "errorDescription": "The operation couldn’t be completed. (sample error 19.)"
        ])
    }

    func testCrashingLogsMessage() throws {
        let logger = SpyLogger()
        let crashExpectation = expectation(description: "exit method called")
        let handler = ErrorHandler(logger: logger) { message in
            guard let event = logger.loggedEvents.first else { return Self.stubbedExit() }
            XCTAssertEqual(event.value, "crash")
            XCTAssertEqual(event.info, ["message": "crash"])
            XCTAssertEqual(message, "crash")
            crashExpectation.fulfill()
            return Self.stubbedExit()
        }

        DispatchQueue.global(qos: .userInitiated).async {
            handler.crash("crash")
        }

        waitForExpectations(timeout: 1)
    }

    func testNotImplementedLogsMessage() throws {
        let logger = SpyLogger()
        let crashExpectation = expectation(description: "exit method called")
        let handler = ErrorHandler(logger: logger) { message in
            guard let event = logger.loggedEvents.first else { return Self.stubbedExit() }
            XCTAssertEqual(event.value, "notImplemented")
            XCTAssertEqual(event.info["file"], #fileID)
            XCTAssertEqual(event.info["function"], #function)
            XCTAssertEqual(message, "Unimplemented function")
            crashExpectation.fulfill()
            return Self.stubbedExit()
        }

        DispatchQueue.global(qos: .userInitiated).async {
            handler.notImplemented()
        }

        waitForExpectations(timeout: 1)
    }

    private static func stubbedExit() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}

private enum SampleError: Error {
    case sample
}
