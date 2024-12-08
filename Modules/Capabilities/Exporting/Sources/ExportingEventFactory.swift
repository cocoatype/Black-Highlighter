//  Created by Geoff Pado on 12/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Defaults
import Logging

struct ExportingEventFactory {
    enum OutputStyle {
        case inPlace
        case copy
    }

    private static let eventName: Event.Name = "Exporting.successfulExport"
    private static let styleKey = "style"
    private static let exportCountKey = "exportCount"
    func event(style: OutputStyle) -> Event {
        let styleValue = switch style {
        case .inPlace: "inPlace"
        case .copy: "copy"
        }

        return Event(
            name: Self.eventName,
            info: [
                Self.styleKey: styleValue,
                Self.exportCountKey: String(Defaults.numberOfSaves),
            ]
        )
    }
}
