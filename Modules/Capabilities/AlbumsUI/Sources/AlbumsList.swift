//  Created by Geoff Pado on 7/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import AlbumsData
import AppNavigation
import SwiftUI

public struct AlbumsList: View {
    @State private var selectedCollectionIdentifier: String?
    var navigationWrapper = NavigationWrapper.empty
    let data: [PhotoCollectionSection]
    init(data: [PhotoCollectionSection], selectedCollectionIdentifier: String? = PhotoCollectionType.library.defaultCollection.identifier) {
        self.data = data
        self.selectedCollectionIdentifier = selectedCollectionIdentifier
    }

    public var body: some View {
        return List(selection: $selectedCollectionIdentifier) {
            ForEach(data, id: \.title) { section in
                Section(header: AlbumsSectionHeader(section.title)) {
                    ForEach(section.collections, id: \.identifier) { collection in
                        AlbumsRow(collection, selection: $selectedCollectionIdentifier)
                    }
                }.accentColor(.white)
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("AlbumsViewController.navigationTitle")
        .environmentObject(navigationWrapper)
        .albumsListBackground()
    }
}

enum AlbumsList_Previews: PreviewProvider {
    static let fakeData = [
        PhotoCollectionSection(title: "Smart Collections", collections: [
            DummyCollection(title: "Recent Photos", iconName: "clock"),
            DummyCollection(title: "Screenshots", iconName: "camera.viewfinder"),
            DummyCollection(title: "Favorites", iconName: "suit.heart"),
        ]),
        PhotoCollectionSection(title: "User Collections", collections: []),
    ]

    static var previews: some View {
        AlbumsList(data: fakeData, selectedCollectionIdentifier: nil)
            .preferredColorScheme(.dark)
    }
}

struct DummyCollection: PhotoCollection {
    let title: String?
    let icon: String
    let identifier: String

    init(title: String, iconName: String) {
        self.title = title
        self.icon = iconName
        self.identifier = title
    }
}
