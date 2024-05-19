//  Created by Geoff Pado on 5/16/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Logging
import TestHelpersInterface

public class SpyLogger: Logger {
    public init(
        logExpectation: Expectation? = nil
    ) {
        self.logExpectation = logExpectation
    }

    private(set) public var loggedEvents = [Event]()
    public var logExpectation: Expectation?
    public func log(_ event: Event) {
        loggedEvents.append(event)
    }
}
