//  Created by Geoff Pado on 12/4/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Logging
import UIKit

final class UnpurchasedAlertController: UIAlertController {
    var logger: any Logger = Logging.logger

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logger.log(Event(name: "UnpurchasedAlertController.viewDidAppear"))
    }
}
