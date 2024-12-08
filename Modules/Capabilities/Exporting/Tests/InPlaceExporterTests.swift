//  Created by Geoff Pado on 12/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Defaults
import LoggingDoubles
import XCTest

@testable import Exporting
@testable import Logging

class InPlaceExporterTests: XCTestCase {
    func testWhenExporterSucceedsThenEventLogged() async throws {
        let asset = StubExportableAsset()
        let outputFactory = StubOutputFactory()
        let logger = SpyLogger()
        let exporter = InPlaceExporter(
            asset: asset,
            outputFactory: outputFactory,
            logger: logger,
            library: StubPhotoLibrary()
        )
        Defaults.numberOfSaves = 0

        try await exporter.export()

        let loggedEvent = try XCTUnwrap(logger.loggedEvents.first)
        XCTAssertEqual(loggedEvent.name, "Exporting.successfulExport")
        XCTAssertEqual(loggedEvent.info["style"], "inPlace")
        XCTAssertEqual(loggedEvent.info["exportCount"], "1")
    }
}
