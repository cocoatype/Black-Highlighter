//  Created by Geoff Pado on 3/28/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class HighlighterToolBarButtonItem: UIBarButtonItem {
    convenience init(tool: HighlighterTool, target: AnyObject?) {
        self.init(title: Self.buttonTitle, image: tool.image)

        menu = UIMenu(
            image: HighlighterTool.magic.image,
            children: HighlighterTool.allCases.map { tool -> UIAction in
                let selector = Self.selectAction(for: tool)
                return UIAction(title: Self.title(for: tool), image: tool.image) { [weak self] _ in
                    guard let responder = self?.target as? UIResponder else { return }
                    let actionTarget = responder.target(forAction: selector, withSender: responder) as? UIResponder
                    actionTarget?.perform(selector, with: responder)
                }
            }
        )
        self.target = target

        accessibilityValue = Self.title(for: tool)
    }

    private static func title(for tool: HighlighterTool) -> String {
        switch tool {
        case .magic: return Strings.magicToolItem
        case .manual: return Strings.manualToolItem
        case .eraser: return Strings.eraserToolItem
        }
    }

    private static func selectAction(for tool: HighlighterTool) -> Selector {
        switch tool {
        case .magic: return #selector(PhotoEditingViewController.selectMagicHighlighter)
        case .manual: return #selector(PhotoEditingViewController.selectManualHighlighter)
        case .eraser: return #selector(PhotoEditingViewController.selectEraser)
        }
    }

    private static let buttonTitle = Strings.buttonTitle

    private typealias Strings = EditingStrings.HighlighterToolBarButtonItem
}
