//  Created by Geoff Pado on 7/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if targetEnvironment(macCatalyst)
import AppKit
import Editing
import Tools
import UIKit

class ToolPickerItem: NSMenuToolbarItem {
    static let identifier = NSToolbarItem.Identifier("ToolPickerItem.identifier")
    let delegate: ToolPickerItemDelegate

    init(delegate: ToolPickerItemDelegate) {
        self.delegate = delegate
        super.init(itemIdentifier: Self.identifier)
        image = selectedToolImage
        label = Strings.itemLabel
        itemMenu = currentMenu
    }

    private var currentMenu: UIMenu {
        UIMenu(title: Strings.menuTitle, children: [
            UICommand(title: Strings.magicToolItem, image: HighlighterTool.magic.image, action: #selector(PhotoEditingViewController.selectMagicHighlighter), state: (delegate.highlighterTool == .magic ? .on : .off)),
            UICommand(title: Strings.manualToolItem, image: HighlighterTool.manual.image, action: #selector(PhotoEditingViewController.selectManualHighlighter), state: (delegate.highlighterTool == .manual ? .on : .off)),
            UICommand(title: Strings.eraserToolItem, image: HighlighterTool.eraser.image, action: #selector(PhotoEditingViewController.selectEraser), state: (delegate.highlighterTool == .eraser ? .on : .off)),
        ])
    }

    private var selectedToolImage: UIImage? {
        switch delegate.highlighterTool {
        case .magic: return HighlighterTool.magic.image?.applyingSymbolConfiguration(.init(scale: .large))
        case .manual: return HighlighterTool.manual.image?.applyingSymbolConfiguration(.init(scale: .large))
        case .eraser: return HighlighterTool.eraser.image?.applyingSymbolConfiguration(.init(scale: .large))
        }
    }

    override func validate() {
        image = selectedToolImage
        itemMenu = currentMenu
    }

    private typealias Strings = CoreStrings.ToolPickerItem
}

protocol ToolPickerItemDelegate: AnyObject {
    var highlighterTool: HighlighterTool { get }
}
#endif
