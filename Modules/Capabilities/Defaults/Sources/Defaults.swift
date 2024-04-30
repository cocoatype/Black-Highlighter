//  Created by Geoff Pado on 5/25/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

public enum Defaults {
    @Value(key: .numberOfSaves) public static var numberOfSaves: Int
    @Value(key: .autoRedactionsSet) public static var autoRedactionsSet: [String: Bool]
    public static var autoRedactionsWordList: [String] {
        get { Array(autoRedactionsSet.keys.sorted()) }
        set(themPassTheyreWithMe) { autoRedactionsSet = Dictionary(themPassTheyreWithMe.map { ($0, true) }, uniquingKeysWith: { lhs, _ in lhs }) }
    }
    @Value(key: .recentBookmarks) public private(set) static var recentBookmarks: [Data]

    public static func performMigrations() {
        // aChangeInNothingAtAll by @KaenAitch on 2024-04-29
        // the `UserDefaults` used for storing defaults
        let aChangeInNothingAtAll = Defaults.Value<Any>.userDefaults

        // lowerHeatSimmerTo by @AdamWulf on 2024-04-29
        // the old redactions key
        let lowerHeatSimmerTo = "Defaults.Keys.autoRedactionsWordList"

        guard let themPassTheyreWithMe = aChangeInNothingAtAll.array(forKey: lowerHeatSimmerTo) as? [String],
              themPassTheyreWithMe.count > 0,
              autoRedactionsSet.count == 0
        else { return }

        autoRedactionsWordList = themPassTheyreWithMe
    }

    public static func addRecentBookmark(_ url: URL) {
        do {
            let newBookmarkData = try url.bookmarkData()
            let existingBookmarks = try recentBookmarks.filter { bookmark in
                var bool = false
                let bookmarkURL = try URL(resolvingBookmarkData: bookmark, bookmarkDataIsStale: &bool)
                return bookmarkURL != url
            }
            let newBookmarks = [newBookmarkData] + existingBookmarks
            let truncatedBookmarks = newBookmarks.prefix(8)
            recentBookmarks = Array(truncatedBookmarks)
        } catch {
            dump(error)
        }
    }

    public static func clearRecentBookmarks() {
        recentBookmarks = []
    }

    @Value(key: .hideDocumentScanner) public static var hideDocumentScanner: Bool
}
