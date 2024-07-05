//  Created by Geoff Pado on 7/4/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ContinuousCornerImage: View {
    private let name: String
    init(name: String) {
        self.name = name
    }

    var body: some View {
        Image(decorative: name, bundle: .module)
            .clipShape(RoundedRectangle(cornerRadius: 5.6, style: .continuous))
    }
}
