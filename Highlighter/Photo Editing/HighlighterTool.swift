//  Created by Geoff Pado on 5/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

enum HighlighterTool: CaseIterable {
    case magic
    case manual

    var image: UIImage {
        switch self {
        case .magic: return #imageLiteral(resourceName: "Magic Highlighter")
        case .manual: return #imageLiteral(resourceName: "Standard Highlighter.png")
        }
    }
}
