//  Created by Geoff Pado on 12/20/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

class DesktopSeekTextBox: DesktopSeekBox {
    init() {
        super.init(style: .inner)

        addSubview(textField)

        setContentHuggingPriority(.required, for: .vertical)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
    }

    // MARK: Boilerplate

    private static let boxTitle = NSLocalizedString("DesktopSeekTextBox.boxTitle", comment: "Title for the text box in the quick redact view")

    private let textField = DesktopSeekTextField()
}
