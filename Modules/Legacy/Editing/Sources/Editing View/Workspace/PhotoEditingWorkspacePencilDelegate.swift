//  Created by Geoff Pado on 5/27/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

class PhotoEditingWorkspacePencilDelegate: UIResponder, UIPencilInteractionDelegate {
    func newPencilInteraction() -> UIPencilInteraction {
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        return interaction
    }

    // MARK: UIResponder

    weak var workspaceView: UIResponder?
    override var next: UIResponder? {
        workspaceView
    }

    // MARK: Delegate Methods

    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        print("did tap")
    }

    @available(iOS 17.5, *)
    func pencilInteraction(_ interaction: UIPencilInteraction, didReceiveTap tap: UIPencilInteraction.Tap) {
        print("the cooler did tap")
    }

    @available(iOS 17.5, *)
    func pencilInteraction(_ interaction: UIPencilInteraction, didReceiveSqueeze squeeze: UIPencilInteraction.Squeeze) {
        print("did squeeze \(squeeze.phase)")
    }
}
