//  Created by Geoff Pado on 2/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Foundation

extension Defaults {
    public enum Key: String {
        case numberOfSaves = "Defaults.Keys.numberOfSaves2"
        case autoRedactionsCategoryNames = "Defaults.Keys.autoRedactionsCategoryNames"
        case autoRedactionsCategoryAddresses = "Defaults.Keys.autoRedactionsCategoryAddresses"
        case autoRedactionsCategoryPhoneNumbers = "Defaults.Keys.autoRedactionsCategoryPhoneNumbers"
        case autoRedactionsSet = "Defaults.Keys.autoRedactionsSet"
        case recentBookmarks = "Defaults.Keys.recentBookmarks"
        case hideDocumentScanner = "Defaults.Keys.hideDocumentScanner"
        case hideAutoRedactions = "Defaults.Keys.hideAutoRedactions"

        // Debug Overlay
        case showDetectedTextOverlay = "Defaults.Keys.showDetectedTextOverlay"
        case showDetectedCharactersOverlay = "Defaults.Keys.showDetectedCharactersOverlay"
        case showRecognizedTextOverlay = "Defaults.Keys.showRecognizedTextOverlay"
        case showCalculatedOverlay = "Defaults.Keys.showCalculatedOverlay"
        case showCombinedOverlay = "Defaults.Keys.showCombinedOverlay"
    }
}
