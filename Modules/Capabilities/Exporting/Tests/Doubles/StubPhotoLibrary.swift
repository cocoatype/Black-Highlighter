//  Created by Geoff Pado on 12/8/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

@testable import Exporting

struct StubPhotoLibrary: PhotoLibrary {
    func performChanges(_ changeBlock: @escaping () -> Void) async throws {}
}
