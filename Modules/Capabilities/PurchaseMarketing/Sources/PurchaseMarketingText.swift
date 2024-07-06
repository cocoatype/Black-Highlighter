//  Created by Geoff Pado on 5/30/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct PurchaseMarketingText: View {
    private let text: String
    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .lineSpacing(3)
            .font(.app(textStyle: Self.textStyle))
            .foregroundColor(Color(.white))
    }

    private static let textStyle: UIFont.TextStyle = {
        #if targetEnvironment(macCatalyst)
        return .body
        #else
        return .footnote
        #endif
    }()
}

enum PurchaseMarketingTextPreviews: PreviewProvider {
    static var previews: some View {
        PurchaseMarketingText("PurchaseMarketingView.supportDevelopmentText")
            .preferredColorScheme(.dark)
    }
}
