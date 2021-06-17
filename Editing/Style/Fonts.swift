//  Created by Geoff Pado on 4/3/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import SwiftUI
import UIKit

public extension UIFont {
    class func appFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        let fontMethod: ((UIFont.TextStyle) -> UIFont)
        switch textStyle {
        case .headline, .title2, .title3:
            fontMethod = boldFont(for:)
        default:
            fontMethod = regularFont(for:)
        }

        let standardFont = fontMethod(textStyle)
        return fontMetrics.scaledFont(for: standardFont)
    }

    // MARK: Font Styles

    class var navigationBarLargeTitleFont: UIFont {
        return boldFont(for: .largeTitle)
    }

    class var navigationBarTitleFont: UIFont {
        return boldFont(for: .headline)
    }

    class var navigationBarButtonFont: UIFont {
        return regularFont(for: .subheadline)
    }

    // MARK: Boilerplate

    fileprivate static let boldFontName = "Aleo-Bold"
    fileprivate static let regularFontName = "Aleo-Regular"

    private static func boldFont(for textStyle: UIFont.TextStyle) -> UIFont {
        return standardFont(named: UIFont.boldFontName, for: textStyle)
    }

    private static func regularFont(for textStyle: UIFont.TextStyle) -> UIFont {
        return standardFont(named: UIFont.regularFontName, for: textStyle)
    }

    private static func standardFont(named name: String, for textStyle: UIFont.TextStyle) -> UIFont {
        let size = standardFontSize(for: textStyle)
        guard let appFont = UIFont(name: name, size: size) else {
            ErrorHandling.crash("Couldn't get regular font")
        }

        return appFont
    }

    fileprivate static func standardFontSize(for textStyle: UIFont.TextStyle) -> CGFloat {
        #if targetEnvironment(macCatalyst)
        return macStandardFontSize(for: textStyle)
        #else
        return mobileStandardFontSize(for: textStyle)
        #endif
    }

    private static func macStandardFontSize(for textStyle: UIFont.TextStyle) -> CGFloat {
        switch textStyle {
        case .largeTitle: return 26.0
        case .title1: return 22.0
        case .title2: return 17.0
        case .title3: return 15.0
        case .headline: return 13.0
        case .body: return 13.0
        case .callout: return 12.0
        case .subheadline: return 11.0
        case .footnote: return 10.0
        case .caption1: return 10.0
        case .caption2: return 10.0
        default: return macStandardFontSize(for: .body)
        }
    }

    private static func mobileStandardFontSize(for textStyle: UIFont.TextStyle) -> CGFloat {
        switch textStyle {
        case .largeTitle: return 34.0
        case .title1: return 28.0
        case .title2: return 22.0
        case .title3: return 20.0
        case .headline: return 17.0
        case .body: return 17.0
        case .callout: return 16.0
        case .subheadline: return 15.0
        case .footnote: return 13.0
        case .caption1: return 12.0
        case .caption2: return 11.0
        default: return mobileStandardFontSize(for: .body)
        }
    }
}

@available(iOS 13.0, iOSApplicationExtension 13.0, *)
extension Font {
    @available(iOS 13.0, iOSApplicationExtension 13.0, *)
    public static func app(textStyle: UIFont.TextStyle) -> Font {
        let fontName: String
        switch textStyle {
        case .headline, .title2, .title3:
            fontName = UIFont.boldFontName
        default:
            fontName = UIFont.regularFontName
        }

        let fontSize = UIFont.standardFontSize(for: textStyle)

        if #available(iOS 14.0, iOSApplicationExtension 14.0, *) {
            return Font.custom(fontName, size: fontSize, relativeTo: textStyle.swiftUI)
        } else {
            return Font.custom(fontName, size: fontSize)
        }
    }

    // MARK: Special

    public static var navigationBarButtonFont: Font {
        return Font(UIFont.navigationBarButtonFont)
    }

    // MARK: Text Styles

    public static var sidebarItem: Font {
        return app(textStyle: .body)
    }
}

@available(iOS 13.0, iOSApplicationExtension 13.0, *)
extension UIFont.TextStyle {
    @available(iOS 13.0, iOSApplicationExtension 13.0, *)
    var swiftUI: Font.TextStyle {
        if #available(iOS 14.0, iOSApplicationExtension 14.0, *) {
            switch self {
            case .largeTitle: return .largeTitle
            case .title1: return .title
            case .title2: return .title2
            case .title3: return .title3
            case .headline: return .headline
            case .body: return .body
            case .callout: return .callout
            case .subheadline: return .subheadline
            case .footnote: return .footnote
            case .caption1: return .caption
            case .caption2: return .caption2
            default: return .body
            }
        } else {
            switch self {
            case .largeTitle: return .largeTitle
            case .title1: return .title
            case .headline: return .headline
            case .body: return .body
            case .callout: return .callout
            case .subheadline: return .subheadline
            case .footnote: return .footnote
            case .caption1: return .caption
            default: return .body
            }
        }
    }
}
