//  Created by Geoff Pado on 1/20/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Foundation

public protocol RedactableObservation {
    var characterObservations: [CharacterObservation] { get }
}
