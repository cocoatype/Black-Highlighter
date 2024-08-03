//  Created by Geoff Pado on 7/9/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Combine
import SwiftUI
import Tools
import UIKit

class PhotoEditingPencilMenuViewController: UIHostingController<PhotoEditingPencilMenuOverlay>, PhotoEditingPencilMenuLiaison.Delegate {
    private let liaison = PhotoEditingPencilMenuLiaison()
    private var cancellables = Set<AnyCancellable>()

    init() {
        super.init(rootView: PhotoEditingPencilMenuOverlay(liaison: liaison))
        view.isOpaque = false
        view.backgroundColor = .clear
        liaison.delegate = self
        view.isUserInteractionEnabled = false

        liaison.$state.sink { [weak self] state in
            self?.view.isUserInteractionEnabled = switch state {
            case .open: true
            case .squeezed, .closed: false
            }
        }.store(in: &cancellables)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
    }

    func updateMenu(at position: CGPoint?, phase: PencilMenuInteractionPhase) {
        switch phase {
        case .began:
            menuBegan(at: position)
        case .changed:
            menuChanged(at: position)
        case .ended:
            menuEnded()
        case .cancelled:
            menuCancelled()
        }
    }

    func menuBegan(at position: CGPoint?) {
        var position = position
        if position == nil && liaison.menuPosition == .zero {
            position = view.bounds.center
        }

        switch liaison.state {
        case .open:
            liaison.state = .squeezed(next: .closed)
        case .closed:
            if let position {
                liaison.menuPosition = position
            }
            liaison.state = .squeezed(next: .open)
        case .squeezed:
            // should never happen
            break
        }
    }

    func menuChanged(at position: CGPoint?) {
        liaison.hoverPosition = position
    }

    func menuEnded() {
        // if we aren't showing the menu, do nothing
        guard liaison.state.isOpen else { return }

        // if something is selected, update the editing view and close
        if let selectedTool = liaison.wrapThoseChilderen {
            completeMenu(with: selectedTool)
        } else if case .squeezed(let next) = liaison.state { // otherwise, move to the next state
            liaison.state = next
        }
    }

    func menuCancelled() {
        liaison.state = .closed
    }

    // MARK: Liaison Delegate

    func completeMenu(with tool: HighlighterTool) {
        UIApplication.shared.sendAction(#selector(HighlighterToolSelectionHandler.selectHighlighterTool(_:event:)), to: nil, from: self, for: HighlighterToolSelectionEvent(tool: tool))
        liaison.state = .closed
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
