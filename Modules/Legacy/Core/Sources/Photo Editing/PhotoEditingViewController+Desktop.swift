//  Created by Geoff Pado on 8/10/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import AppRatings
import Defaults
import Editing
import ErrorHandling
import Exporting
import UIKit
import UniformTypeIdentifiers

#if targetEnvironment(macCatalyst)
extension PhotoEditingViewController {
    private var imageType: UTType? {
        guard let imageTypeString = image?.cgImage?.utType
        else { return nil }

        return UTType(imageTypeString as String)
    }

    @objc func save(_ sender: Any) {
        guard let exportURL = fileURLProvider?.representedFileURL else { return saveAs(sender) }

        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                try await FileManager.default.copyItem(at: preparedURL, to: exportURL)
                clearHasMadeEdits()

                Defaults.numberOfSaves += 1
                AppRatingsPrompter().displayRatingsPrompt(in: view.window?.windowScene)
            } catch {
                ErrorHandler().log(error)
            }
        }
    }

    @objc func saveAs(_ sender: Any) {
        Task { @MainActor [weak self] in
            do {
                self?.clearHasMadeEdits()

                Defaults.numberOfSaves += 1
                guard let self else { return }
                let temporaryURL = try await preparedURL
                let saveViewController = DesktopSaveViewController(url: temporaryURL) { [weak self] urls in
                    AppRatingsPrompter().displayRatingsPrompt(in: self?.view.window?.windowScene)
                    if let exportURL = urls.first {
                        self?.fileURLProvider?.updateRepresentedFileURL(to: exportURL)
                    }
                }
                present(saveViewController, animated: true)
            } catch {
                ErrorHandler().log(error)
            }
        }
    }

    private func present(_ error: DesktopSaveError) {
        present(DesktopSaveAlertController(error: error), animated: true, completion: nil)
    }

    var canSave: Bool {
        guard let imageType = imageType else { return false }
        guard hasMadeEdits == true else { return false }
        return [UTType.png, .jpeg].contains(imageType)
    }
}
#endif
