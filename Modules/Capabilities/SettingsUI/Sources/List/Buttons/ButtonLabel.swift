//  Created by Geoff Pado on 7/4/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ButtonLabel: View {
    private let title: String
    private let subtitle: String?
    private let imageName: String?

    init(title: String, subtitle: String? = nil, imageName: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
    }

    var body: some View {
        HStack(spacing: 12) {
            if let imageName { ContinuousCornerImage(name: imageName) }
            VStack(alignment: .leading) {
                TitleText(title)
                if let subtitle { SubtitleText(subtitle) }
            }
        }
    }
}
