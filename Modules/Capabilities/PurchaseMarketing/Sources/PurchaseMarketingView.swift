//  Created by Geoff Pado on 5/18/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import DesignSystem
import SwiftUI

public struct PurchaseMarketingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    public init() {}

    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Color.primaryDark
                Color.appPrimary
            }.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    ZStack(alignment: .topTrailing) {
                        topBar(forWidth: proxy.size.width)
                        PurchaseMarketingCloseButton()
                    }
                    LazyVGrid(columns: columns(forWidth: proxy.size.width), spacing: 20) {
                        PurchaseMarketingItem(
                            header: Strings.autoRedactionsHeader,
                            text: Strings.autoRedactionsText,
                            imageName: "Seek")
                        #if !targetEnvironment(macCatalyst)
                        PurchaseMarketingItem(
                            header: Strings.documentScanningHeader,
                            text: Strings.documentScanningText,
                            imageName: "Scanner")
                        #endif
                        PurchaseMarketingItem(
                            header: Strings.shortcutsHeader,
                            text: Strings.shortcutsText,
                            imageName: "Shortcuts")
                        PurchaseMarketingItem(
                            header: Strings.supportDevelopmentHeader,
                            text: Strings.supportDevelopmentText,
                            imageName: "Support")
                        PurchaseMarketingItem(
                            header: Strings.crossPlatformHeader,
                            text: Strings.crossPlatformText,
                            imageName: "Systems")
                    }.padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
                        .background(Color.appPrimary)
                }
            }
            .fill()
            .navigationBarHidden(true)
        }
    }

    private static let breakWidth = Double(640)

    @ViewBuilder
    private func topBar(forWidth width: Double) -> some View {
        if width < Self.breakWidth {
            PurchaseMarketingTopBarCompact()
        } else {
            PurchaseMarketingTopBarRegular()
        }
    }

    private func columns(forWidth width: Double) -> [GridItem] {
        if width < Self.breakWidth {
            return [GridItem(spacing: 20)]
        } else {
            return [GridItem(spacing: 20), GridItem(spacing: 20)]
        }
    }

    private typealias Strings = PurchaseMarketingStrings.PurchaseMarketingView
}

enum PurchaseMarketingView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseMarketingView()
            .preferredColorScheme(.dark)
            .environment(\.readableWidth, 288)
//            .previewLayout(.fixed(width: 640, height: 1024))
    }
}
