//  Created by Geoff Pado on 7/1/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import Photos
import UIKit

class SaveCopyActivity: UIActivity {
    override var activityTitle: String? {
        ExportingStrings.SaveCopyActivity.title
    }

    override var activityImage: UIImage? {
        ExportingAsset.saveCopy.image
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return activityItems.count == 1 && activityItems.first is URL
    }

    private var activityURL: URL?
    override func prepare(withActivityItems activityItems: [Any]) {
        activityURL = activityItems.first as? URL
    }

    override func perform() {
        guard let activityURL else { return ErrorHandler().log(ExportingError.noActivityURL) }

        Task {
            do {
                try await CopyExporter(preparedURL: activityURL).export()
            } catch {
                ErrorHandler().log(error)
            }
        }
    }
}
