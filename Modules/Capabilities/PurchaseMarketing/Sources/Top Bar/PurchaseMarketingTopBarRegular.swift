//  Created by Geoff Pado on 1/19/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct PurchaseMarketingTopBarRegular: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            PurchaseMarketingTopBarHeadline()
            PurchaseMarketingTopBarSubheadline()
        }
        .padding(40)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.primaryDark)
    }
}

#Preview {
    PurchaseMarketingTopBarRegular()
}
