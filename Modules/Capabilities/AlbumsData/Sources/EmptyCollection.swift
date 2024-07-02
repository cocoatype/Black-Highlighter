//  Created by Geoff Pado on 7/1/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DesignSystem

struct EmptyCollection: PhotoCollection {
    var title: String? { nil }
    var icon: String { Icons.standardCollection }
    var identifier: String { "" }
}
