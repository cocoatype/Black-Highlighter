//  Created by Geoff Pado on 12/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Tools
import UIKit
import XCTest

@testable import Editing
@testable import Logging

class PhotoEditingWorkspaceViewTelemetryEventFactoryTests: XCTestCase {
    func check(_ event: Event, hasTool tool: HighlighterTool, color: UIColor?) {
        XCTAssertEqual(event.name, "PhotoEditingWorkspaceView.strokeCompleted")
        switch tool {
        case .magic:
            XCTAssertEqual(event.info["tool"], "magic")
        case .manual:
            XCTAssertEqual(event.info["tool"], "manual")
        case .eraser:
            XCTAssertEqual(event.info["tool"], "eraser")
        }

        if let color {
            XCTAssertEqual(event.info["color"], color.hexString)
        } else {
            XCTAssertNil(event.info["color"])
        }
    }

    func testEventWithMagicToolAndBlackColor() {
        let event = PhotoEditingWorkspaceViewTelemetryEventFactory().event(
            tool: .magic,
            color: .black
        )

        check(event, hasTool: .magic, color: .black)
    }

    func testEventWithMagicToolAndRedColor() {
        let event = PhotoEditingWorkspaceViewTelemetryEventFactory().event(
            tool: .magic,
            color: .red
        )

        check(event, hasTool: .magic, color: .red)
    }

    func testEventWithManualToolAndBlackColor() {
        let event = PhotoEditingWorkspaceViewTelemetryEventFactory().event(
            tool: .manual,
            color: .black
        )

        check(event, hasTool: .manual, color: .black)
    }

    func testEventWithManualToolAndRedColor() {
        let event = PhotoEditingWorkspaceViewTelemetryEventFactory().event(
            tool: .manual,
            color: .red
        )

        check(event, hasTool: .manual, color: .red)
    }

    func testEventWithEraserToolAndBlackColor() {
        let event = PhotoEditingWorkspaceViewTelemetryEventFactory().event(
            tool: .eraser,
            color: .black
        )

        check(event, hasTool: .eraser, color: nil)
    }

    func testEventWithEraserToolAndRedColor() {
        let event = PhotoEditingWorkspaceViewTelemetryEventFactory().event(
            tool: .eraser,
            color: .red
        )

        check(event, hasTool: .eraser, color: nil)
    }
}
