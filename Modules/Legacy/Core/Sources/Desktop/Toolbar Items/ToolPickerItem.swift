//  Created by Geoff Pado on 7/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if targetEnvironment(macCatalyst)
import AppKit
import Editing
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
            UICommand(title: Strings.magicToolItem, image: UIImage(named: "highlighter.magic"), action: #selector(PhotoEditingViewController.selectMagicHighlighter), state: (delegate.highlighterTool == .magic ? .on : .off)),
            UICommand(title: Strings.manualToolItem, image: UIImage(systemName: "highlighter"), action: #selector(PhotoEditingViewController.selectManualHighlighter), state: (delegate.highlighterTool == .manual ? .on : .off)),
            UICommand(title: Strings.eraserToolItem, image: UIImage(named: "highlighter.eraser"), action: #selector(PhotoEditingViewController.selectEraser), state: (delegate.highlighterTool == .eraser ? .on : .off)),
        ])
    }

    private var selectedToolImage: UIImage? {
        switch delegate.highlighterTool {
        case .magic: return UIImage(named: "highlighter.magic")?.applyingSymbolConfiguration(.init(scale: .large))
        case .manual: return UIImage(named: "highlighter.manual")?.applyingSymbolConfiguration(.init(scale: .large))
        case .eraser: return UIImage(named: "highlighter.eraser")?.applyingSymbolConfiguration(.init(scale: .large))
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
