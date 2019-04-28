//  Created by Geoff Pado on 4/27/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

class SettingsContentProvider: NSObject {
    enum Section: Equatable {
        case about, otherApps

        var items: [Item] {
            switch self {
            case .about: return [.about, .privacy, .acknowledgements, .contact]
            case .otherApps: return []
            }
        }

        var header: String? { return nil }
    }

    enum Item: Equatable {
        case about, acknowledgements, contact, otherApp, privacy

        var title: String {
            switch self {
            case .about: return NSLocalizedString("SettingsContentProvider.Item.about", comment: "Title for the about settings item")
            case .acknowledgements: return NSLocalizedString("SettingsContentProvider.Item.acknowledgements", comment: "Title for the acknowledgements settings item")
            case .contact: return NSLocalizedString("SettingsContentProvider.Item.contact", comment: "Title for the contact settings item")
            case .otherApp: return ""
            case .privacy: return NSLocalizedString("SettingsContentProvider.Item.privacy", comment: "Title for the privacy policy settings item")
            }
        }
    }

    private var sections: [Section] { return [.about, .otherApps] }

    // MARK: Data

    func sectionIndex(for section: Section) -> Int? {
        return sections.firstIndex(where: { $0 == section })
    }

    var numberOfSections: Int {
        return sections.count
    }

    func numberOfItems(inSectionAtIndex index: Int) -> Int {
        return sections[index].items.count
    }

    func section(at index: Int) -> Section {
        return sections[index]
    }

    func item(at indexPath: IndexPath) -> Item {
        return sections[indexPath.section].items[indexPath.row]
    }
}
