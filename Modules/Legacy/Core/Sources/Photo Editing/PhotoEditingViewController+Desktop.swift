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
        guard let imageType = imageType else { return present(.missingImageType) }

        Task { [weak self] in
            let image = try? await exportImage()
            let data: Data?

            switch imageType {
            case .jpeg:
                data = image?.jpegData(compressionQuality: 0.9)
            default:
                data = image?.pngData()
            }

            guard let exportData = data else {
                DispatchQueue.main.async { [weak self] in
                    self?.present(.noImageData)
                }
                return
            }
            do {
                try exportData.write(to: exportURL)
                self?.clearHasMadeEdits()

                Defaults.numberOfSaves += 1
                DispatchQueue.main.async { [weak self] in
                    AppRatingsPrompter().displayRatingsPrompt(in: self?.view.window?.windowScene)
                }
            } catch {
                ErrorHandler().log(error)
            }
        }
    }

    @objc func saveAs(_ sender: Any) {
        guard let imageType = imageType else { return present(.missingImageType) }

        let representedURLName = fileURLProvider?.representedFileURL?.lastPathComponent ?? "\(ExportingStrings.PhotoEditingExporter.defaultImageName).\(imageType.preferredFilenameExtension ?? "png")"
        let temporaryURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(representedURLName)

        Task { [weak self] in
            let image = try? await exportImage()
            let data: Data?

            switch imageType {
            case .jpeg:
                data = image?.jpegData(compressionQuality: 0.9)
            default:
                data = image?.pngData()
            }

            guard let exportData = data else {
                DispatchQueue.main.async { [weak self] in
                    self?.present(.noImageData)
                }
                return
            }
            do {
                try exportData.write(to: temporaryURL)
                self?.clearHasMadeEdits()

                Defaults.numberOfSaves += 1
                DispatchQueue.main.async { [weak self] in
                    let saveViewController = DesktopSaveViewController(url: temporaryURL) { [weak self] urls in
                        AppRatingsPrompter().displayRatingsPrompt(in: self?.view.window?.windowScene)
                        if let exportURL = urls.first {
                            self?.fileURLProvider?.updateRepresentedFileURL(to: exportURL)
                        }
                    }
                    self?.present(saveViewController, animated: true, completion: nil)
                }
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
