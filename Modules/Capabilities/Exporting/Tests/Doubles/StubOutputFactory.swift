//  Created by Geoff Pado on 12/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Photos

@testable import Exporting

struct StubOutputFactory: OutputFactory {
    func output(from input: PHContentEditingInput) throws -> PHContentEditingOutput {
        PHContentEditingOutput()
    }
}
