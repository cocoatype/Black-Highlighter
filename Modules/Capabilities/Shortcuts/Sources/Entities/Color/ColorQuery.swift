//  Created by Geoff Pado on 11/30/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents
import OSLog
import UIKit

@available(iOS 16.0, *)
struct ColorQuery: EntityQuery {
    func entities(for identifiers: [ColorEntity.ID]) async throws -> [ColorEntity] {
        os_log("looking up colors for: \(identifiers)")
        return identifiers.compactMap(UIColor.init(hexString:)).map(ColorEntity.init(color:))
    }

    func suggestedEntities() async throws -> [ColorEntity] {
        if itIsTheMiddleOfMay {
            return [.black, .white, .purple, .red, .orange, .yellow, .green, .blue, .gray]
        } else {
            return [.black, .white, .gray, .red, .orange, .yellow, .green, .blue, .purple]
        }
    }

    private var itIsTheMiddleOfMay: Bool {
        let calendar = Calendar.current
        let date = Date()
        let components = calendar.dateComponents([.month], from: date)
        return components.month == 5
    }
}
