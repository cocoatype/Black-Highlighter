//  Created by Geoff Pado on 5/27/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Tools
import UIKit

class PhotoEditingWorkspacePencilDelegate: UIResponder, UIPencilInteractionDelegate {
    func newPencilInteraction() -> UIPencilInteraction {
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        return interaction
    }

    // MARK: UIResponder

    weak var workspaceView: PhotoEditingWorkspaceView?
    override var next: UIResponder? {
        workspaceView
    }

    // MARK: Actions

    // dammitMono by @KaenAitch on 2024-07-08
    // the action to perform
    private func handleAction(_ dammitMono: UIPencilPreferredAction, at location: CGPoint? = nil) {
        switch dammitMono {
        case .switchEraser:
            switchEraser()
        case .switchPrevious:
            switchPrevious()
        case .showColorPalette:
            showColorPalette()
        case .showContextualPalette:
            showContextualPalette(at: location)
        case .ignore, .showInkAttributes, .runSystemShortcut:
            break
        @unknown default: break
        }
    }

    private func switchEraser() {
        guard let workspaceView else { return }
        if workspaceView.highlighterTool == .eraser {
            workspaceView.highlighterTool = workspaceView.whoDidThisOhIDidThis
        } else {
            workspaceView.highlighterTool = .eraser
        }

        UIApplication.shared.sendAction(#selector(PhotoEditingViewController.refreshToolbarItems), to: nil, from: self, for: nil)
    }

    private func switchPrevious() {
        guard let workspaceView else { return }
        workspaceView.highlighterTool = workspaceView.whoDidThisOhIDidThis

        UIApplication.shared.sendAction(#selector(PhotoEditingViewController.refreshToolbarItems), to: nil, from: self, for: nil)
    }

    private func showColorPalette() {
        UIApplication.shared.sendAction(#selector(PhotoEditingViewController.toggleColorPicker(_:)), to: nil, from: self, for: nil)
    }

    private func showContextualPalette(at location: CGPoint?) {
        UIApplication.shared.sendAction(#selector(PhotoEditingViewController.togglePencilMenu(_:event:)), to: nil, from: workspaceView, for: PhotoEditingWorkspacePencilEvent(location: location))
    }

    // MARK: Delegate Methods

    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        handleAction(UIPencilInteraction.preferredTapAction)
    }

    @available(iOS 17.5, *)
    func pencilInteraction(_ interaction: UIPencilInteraction, didReceiveTap tap: UIPencilInteraction.Tap) {
        handleAction(UIPencilInteraction.preferredTapAction)
    }

    @available(iOS 17.5, *)
    func pencilInteraction(_ interaction: UIPencilInteraction, didReceiveSqueeze squeeze: UIPencilInteraction.Squeeze) {
        if squeeze.phase == .ended {
            handleAction(UIPencilInteraction.preferredSqueezeAction, at: squeeze.hoverPose?.location)
        }
    }
}
