//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import XCTest

@testable import UserActivities

class LaunchActivityTests: XCTestCase {
    func testInitSetsUserInfoKey() throws {
        let fileURL = URL(fileURLWithPath: "/path")

        let launchActivity = LaunchActivity(fileURL)

        let urlString = try XCTUnwrap(launchActivity.userInfo?[LaunchActivity.launchActivityURLKey] as? String)
        XCTAssertEqual(urlString, "file:///path")
    }

    func testInitWithCompleteUserActivity() throws {
        let userActivity = NSUserActivity(activityType: LaunchActivity.activityType)
        userActivity.userInfo = [
            LaunchActivity.launchActivityURLKey: "file:///path"
        ]

        let launchActivity = try XCTUnwrap(LaunchActivity(userActivity: userActivity))

        let urlString = try XCTUnwrap(launchActivity.userInfo?[LaunchActivity.launchActivityURLKey] as? String)
        XCTAssertEqual(urlString, "file:///path")
    }

    func testInitWithIncorrectActivityType() throws {
        let userActivity = NSUserActivity(activityType: "com.example.bad")
        userActivity.userInfo = [
            LaunchActivity.launchActivityURLKey: "file:///path"
        ]

        XCTAssertNil(LaunchActivity(userActivity: userActivity))
    }

    func testInitWithMissingUserInfo() throws {
        let userActivity = NSUserActivity(activityType: LaunchActivity.activityType)

        XCTAssertNil(LaunchActivity(userActivity: userActivity))
    }

    func testRepresentedURL() throws {
        let fileURL = URL(fileURLWithPath: "/path")

        let launchActivity = try XCTUnwrap(LaunchActivity(fileURL))

        try XCTAssertEqual(XCTUnwrap(launchActivity.representedURL), fileURL)
    }

    func testRepresentedURLWithMissingUserInfo() throws {
        let fileURL = URL(fileURLWithPath: "/path")

        let launchActivity = try XCTUnwrap(LaunchActivity(fileURL))
        launchActivity.userInfo = nil

        XCTAssertNil(launchActivity.representedURL)
    }
}
