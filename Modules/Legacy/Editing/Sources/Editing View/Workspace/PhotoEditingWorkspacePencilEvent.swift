//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Tools
import UIKit

class PhotoEditingWorkspacePencilEvent: UIEvent {
    let location: CGPoint?
    let phase: PencilMenuInteractionPhase

    @available(iOS 17.5, *)
    init(location: CGPoint? = nil, phase: UIPencilInteraction.Phase) {
        self.location = location
        self.phase = PencilMenuInteractionPhase(phase)
    }
}
