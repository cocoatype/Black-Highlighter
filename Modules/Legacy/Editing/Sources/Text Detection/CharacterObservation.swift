//  Created by Geoff Pado on 5/1/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import Redactions

struct CharacterObservation: Hashable {
    let bounds: Shape
    let textObservationUUID: UUID
}
