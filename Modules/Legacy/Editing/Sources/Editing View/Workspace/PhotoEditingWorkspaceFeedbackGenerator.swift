//  Created by Geoff Pado on 8/2/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

protocol PhotoEditingWorkspaceFeedbackGenerator {
    init(view: UIView)
    func prepare()
    func pathCompleted(at location: CGPoint)
}

@available(iOS 17.5, *)
extension UICanvasFeedbackGenerator: PhotoEditingWorkspaceFeedbackGenerator {}
