//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

class PhotoEditingWorkspacePencilEvent: UIEvent {
    let location: CGPoint?
    let isCancelled: Bool?

    init(location: CGPoint? = nil, isCancelled: Bool? = nil) {
        self.location = location
        self.isCancelled = isCancelled
    }
}
