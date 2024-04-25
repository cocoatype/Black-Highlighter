//  Created by Geoff Pado on 4/25/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

public struct IntroButton: View {
    private let action: (() -> Void)
    private let titleKey: LocalizedStringKey
    public init(_ titleKey: LocalizedStringKey, action: @escaping (() -> Void)) {
        self.action = action
        self.titleKey = titleKey
    }

    public var body: some View {
        Button(action: action) {
            Text(titleKey)
                .font(.app(textStyle: .headline))
                .foregroundColor(.white)
                .underline()
        }
    }
}
