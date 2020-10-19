//  Created by Geoff Pado on 6/26/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Editing
import MobileCoreServices
import Photos
import UIKit

class ActionEditingViewController: BasePhotoEditingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        loadImageFromExtensionContext()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ActionEditingViewController.done))
    }

    private func loadImageFromExtensionContext() {
        let imageTypeIdentifier = (kUTTypeImage as String)

        let imageProvider = extensionContext?
            .inputItems
            .compactMap { $0 as? NSExtensionItem }
            .flatMap { $0.attachments ?? [] }
            .first(where: { $0.hasItemConformingToTypeIdentifier(imageTypeIdentifier) })

        imageProvider?.loadItem(forTypeIdentifier: imageTypeIdentifier, options: nil) { [weak self] item, error in
            do {
                guard let imageURL = (item as? URL) else { throw (error ?? ActionError.imageURLNotFound)  }

                let imageData = try Data(contentsOf: imageURL)
                guard let image = UIImage(data: imageData) else { throw ActionError.invalidImageData }

                DispatchQueue.main.async { [weak self] in
                    self?.load(image)
                }
            } catch {
                dump(error)
            }
        }
    }

    @objc private func done(_ sender: UIBarButtonItem) {
        let alertController = ActionEditingDismissalAlertController() { [weak self] response in
            switch response {
            case .delete:
                self?.dismissActionExtension()
            case .save:
                self?.exportImage { image in
                    guard let imageForExport = image else { return }

                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAsset(from: imageForExport)
                    }, completionHandler: { [weak self] success, error in
                        assert(success, "an error occurred saving changes: \(error?.localizedDescription ?? "no error")")
                        DispatchQueue.main.async {
                            self?.dismissActionExtension()
                        }
                    })
                }
            }
        }

        alertController.barButtonItem = sender
        present(alertController, animated: true)
    }

    private func dismissActionExtension() {
        exportImage { image in
            let items: [Any]
            if let imageForExport = image {
                let extensionItem = NSExtensionItem()
                let itemProvider = NSItemProvider(item: imageForExport, typeIdentifier: (kUTTypeImage as String))
                extensionItem.attachments = [itemProvider]
                items = [extensionItem]
            } else {
                items = []
            }

            self.extensionContext?.completeRequest(returningItems: items, completionHandler: nil)
        }
    }
}

enum ActionError: Error {
    case imageURLNotFound
    case invalidImageData
}