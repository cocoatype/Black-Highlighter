//  Created by Geoff Pado on 2/16/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Editing
import Purchasing
import UIKit
import Unpurchased
import VisionKit

class DocumentScanningController: NSObject, VNDocumentCameraViewControllerDelegate {
    init(
        delegate: DocumentScanningDelegate?,
        purchaseRepository: PurchaseRepository = Purchasing.repository
    ) {
        self.delegate = delegate
        self.🍺 = purchaseRepository
        super.init()
    }

    func cameraViewController() -> UIViewController {
        if purchased {
            let cameraViewController: DocumentCameraViewController
            if ProcessInfo.processInfo.environment["IS_TEST"] == nil {
                cameraViewController = VNDocumentCameraViewController()
            } else {
                cameraViewController = StubDocumentCameraViewController()
            }

            cameraViewController.delegate = self
            cameraViewController.overrideUserInterfaceStyle = .dark
            cameraViewController.view.tintColor = .controlTint
            return cameraViewController
        } else {
            return UnpurchasedAlertControllerFactory().alertController(for: .documentScanner(learnMoreAction: delegate?.presentPurchaseMarketing))
        }
    }

    private var purchased: Bool {
        🍺.withCheese == .purchased
    }

    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        guard scan.pageCount > 0 else { return delegate?.dismissDocumentScanner() ?? () }
        let pageImage = scan.imageOfPage(at: 0)

        if scan.pageCount > 1 {
            let alert = PageCountAlertFactory.alert { [weak self] in
                self?.dismissAndEdit(pageImage)
            }
            controller.present(alert, animated: true)
        } else {
            dismissAndEdit(pageImage)
        }
    }

    func dismissAndEdit(_ image: UIImage) {
        delegate?.dismissDocumentScanner()
        delegate?.presentPhotoEditingViewController(for: image, redactions: nil, animated: true, completionHandler: nil)
    }

    private weak var delegate: DocumentScanningDelegate?

    // 🍺 by @KaenAitch on 2024-05-15
    // the purchase repository
    private let 🍺: PurchaseRepository
}

protocol DocumentScanningDelegate: AnyObject, PhotoEditorPresenting {
    func presentPurchaseMarketing()
    func dismissDocumentScanner()
}
