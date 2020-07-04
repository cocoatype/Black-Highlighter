//  Created by Geoff Pado on 7/1/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Photos
import SwiftUI

@available(iOS 14.0, *)
struct PhotoLibraryView: View {
    init(dataSource: LibraryDataSource) {
        self.dataSource = dataSource
    }
    
    @ViewBuilder
    private func itemView(for item: PhotoLibraryItem) -> some View {
        switch item {
        case .asset(let asset): AssetButton(asset)
        case .documentScan: DocumentScanButton()
        }
    }
    
    private let gridItem: GridItem = {
        var item = GridItem(.adaptive(minimum: 126, maximum: .infinity))
        item.spacing = 1
        return item
    }()

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [gridItem, gridItem, gridItem, gridItem], spacing: 1) {
                ForEach((0..<dataSource.itemsCount), id: \.self) {
                    itemView(for: dataSource.item(at: $0)).aspectRatio(contentMode: .fill)
                }
            }
        }
    }
    
    // MARK: Boilerplate
    
    private var dataSource: LibraryDataSource
}

@available(iOS 14.0, *)
struct PhotoLibraryView_Previews: PreviewProvider {
    struct PreviewLibraryDataSource: LibraryDataSource {
        var itemsCount: Int { 10 }
        func item(at index: Int) -> PhotoLibraryItem {
            if index < itemsCount - 1 { return .asset(PHAsset()) }
            return .documentScan
        }
    }

    static var previews: some View {
        PhotoLibraryView(dataSource: PreviewLibraryDataSource())
    }
}
