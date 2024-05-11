//  Created by Geoff Pado on 5/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

public class NavigationBar: UINavigationBar {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        tintColor = .white

        standardAppearance = NavigationBarAppearance()
        compactAppearance = NavigationBarAppearance()
        scrollEdgeAppearance = NavigationBarAppearance()

        if #available(iOS 15.0, *) {
            compactScrollEdgeAppearance = NavigationBarAppearance()
        }
        isTranslucent = false
    }

    // MARK: Bar Button Appearance

    static let largeTitleTextAttributes = [
        NSAttributedString.Key.font: UIFont.navigationBarLargeTitleFont
    ]

    public static let buttonTitleTextAttributes = [
        NSAttributedString.Key.font: UIFont.navigationBarButtonFont,
        .foregroundColor: UIColor.white,
    ]

    public static let titleTextAttributes = [
        NSAttributedString.Key.font: UIFont.navigationBarTitleFont,
        .foregroundColor: UIColor.white,
    ]

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
