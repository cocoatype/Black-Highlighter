//  Created by Geoff Pado on 7/2/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import OSLog
import Photos
import Redactions

struct SaveActivityAdjustmentData: Encodable {
    static let formatIdentifier = "com.cocoatype.Highlighter.redactionsAdjustments"
    private let redactions: [Redaction]
    init(redactions: [Redaction]) {
        self.redactions = redactions
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var redactionsContainer = container.nestedUnkeyedContainer(forKey: .redactions)
        try redactionsContainer.encode(contentsOf: redactions.compactMap(RedactionSerializer.dataRepresentation(of:)))
    }

    enum CodingKeys: String, CodingKey {
        case redactions
    }
}
