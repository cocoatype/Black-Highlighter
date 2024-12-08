//  Created by Geoff Pado on 12/8/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
import Redactions

public enum Exporting {
    public static func outputFactory(preparedURL: URL, redactions: [Redaction]) -> any OutputFactory {
        return PhotoOutputFactory(preparedURL: preparedURL, redactions: redactions)
    }
}
