//  Created by Geoff Pado on 4/22/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

class AutoRedactionsEntryTableViewCellField: UITextField {
    private let fieldDelegate = Delegate()

    init() {
        super.init(frame: .zero)

        adjustsFontForContentSizeCategory = true
        autocapitalizationType = .none
        delegate = fieldDelegate
        font = .appFont(forTextStyle: .subheadline)
        placeholder = Self.placeholder
        returnKeyType = .done
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false

        addTarget(nil, action: #selector(AutoRedactionsEditViewController.saveNewWord(_:)), for: .editingDidEnd)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }

    private static let placeholder = NSLocalizedString("AutoRedactionsEntryTableViewCellField.placeholder", comment: "Placeholder text for the add auto-redaction field")

    class Delegate: NSObject, UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
    }
}
