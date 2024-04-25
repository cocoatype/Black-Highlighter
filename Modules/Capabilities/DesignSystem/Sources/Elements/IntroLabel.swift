//  Created by Geoff Pado on 4/25/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

public struct IntroLabel: View {
    private let textKey: LocalizedStringKey
    public init(_ textKey: LocalizedStringKey) {
        self.textKey = textKey
    }

    public var body: some View {
        Text(textKey)
            .foregroundColor(.primaryExtraLight)
            .font(.app(textStyle: .body))
    }
}
