//  Created by Geoff Pado on 4/1/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

public class PromptButton: UIButton {
    public init(title string: String) {
        super.init(frame: .zero)

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.appFont(forTextStyle: .headline),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]

        let underlinedTitle = NSAttributedString(string: string, attributes: attributes)
        setAttributedTitle(underlinedTitle, for: .normal)

        titleLabel?.adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
