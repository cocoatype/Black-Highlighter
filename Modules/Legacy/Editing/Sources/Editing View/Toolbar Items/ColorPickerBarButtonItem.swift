//  Created by Geoff Pado on 8/27/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ColorPickerBarButtonItem: UIBarButtonItem {
    convenience init(target: AnyObject?, color: UIColor) {
        self.init(customView: ColorWell(target: target, color: color))

        UIView.appearance(whenContainedInInstancesOf: [UIColorPickerViewController.self]).overrideUserInterfaceStyle = .dark
        accessibilityLabel = EditingStrings.ColorPickerBarButtonItem.accessibilityLabel
        accessibilityValue = color.accessibilityName
    }

    class ColorWell: UIColorWell {
        init(target: AnyObject?, color: UIColor) {
            super.init(frame: .zero)
            addTarget(target, action: #selector(ActionsBuilderActions.selectedColorDidChange(_:)), for: .primaryActionTriggered)
            selectedColor = color
            overrideUserInterfaceStyle = .dark
            translatesAutoresizingMaskIntoConstraints = false
        }

        // MARK: Boilerplate

        @available(*, unavailable)
        required init(coder: NSCoder) {
            let typeName = NSStringFromClass(type(of: self))
            fatalError("\(typeName) does not implement init(coder:)")
        }
    }
}
