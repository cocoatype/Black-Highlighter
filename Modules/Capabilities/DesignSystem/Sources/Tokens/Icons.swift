//  Created by Geoff Pado on 7/29/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

public enum Icons {
    public static let scanDocument = UIImage(systemName: "doc.text.viewfinder")

    public static let limitedLibrary = UIImage(systemName: "rectangle.stack.badge.plus")

    public static var undo: UIImage? { UIImage(systemName: "arrow.uturn.left") }

    public static var redo: UIImage? { UIImage(systemName: "arrow.uturn.right") }

    public static var seekAndDestroy: UIImage? { UIImage(systemName: "magnifyingglass") }

    public static var help: UIImage? { UIImage(systemName: "gear") }

    public static var albums: UIImage? { UIImage(systemName: "rectangle.stack") }

    // MARK: Collections

    public static let favoritesCollection = "suit.heart"
    public static let recentsCollection = "clock"
    public static let screenshotsCollection = "camera.viewfinder"
    public static let standardCollection = "rectangle.stack"

//    public static var favoritesCollection: UIImage? { UIImage(systemName: "suit.heart")?.withRenderingMode(.alwaysTemplate) }
//
//    public static var recentsCollection: UIImage? { UIImage(systemName: "clock")?.withRenderingMode(.alwaysTemplate) }
//
//    public static var screenshotsCollection: UIImage? { UIImage(systemName: "camera.viewfinder")?.withRenderingMode(.alwaysTemplate) }
//
//    public static var standardCollection: UIImage? { UIImage(systemName: "rectangle.stack")?.withRenderingMode(.alwaysTemplate) }
}
