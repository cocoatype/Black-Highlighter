//  Created by Geoff Pado on 8/30/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import AlbumsData
import AppNavigation
import SwiftUI

struct AlbumsRow: View {
    @Binding var selection: String?
    private let collection: PhotoCollection
    init(_ collection: PhotoCollection, selection: Binding<String?>) {
        self.collection = collection
        self._selection = selection
    }

    var body: some View {
        return Button {
            navigationWrapper.present(collection)
            selection = collection.identifier
        } label: {
            Label(
                title: { Text(collection.title ?? "") },
                icon: {
                    Image(systemName: String(collection.icon))
                        .foregroundColor(.white)
                }
            ).font(.sidebarItem)
            .foregroundColor(.white)
            .id(collection.identifier)
            .tag(collection.identifier)
        }
        .selected(selection == collection.identifier)
        .introspectTableViewCell { $0.selectionStyle = .none }
    }

    @EnvironmentObject private var navigationWrapper: NavigationWrapper
}
