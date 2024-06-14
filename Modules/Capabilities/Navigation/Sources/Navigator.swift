//  Created by Geoff Pado on 6/14/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Redactions
import UIKit

public protocol Navigator {
    @MainActor func navigate(to route: Route)
}

public enum Route {
    case editor(UIImage, [Redaction])
}
