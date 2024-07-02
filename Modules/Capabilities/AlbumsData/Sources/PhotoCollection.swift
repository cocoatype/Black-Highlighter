//  Created by Geoff Pado on 5/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

public protocol PhotoCollection {
    var title: String? { get }
    var icon: String { get }
    var identifier: String { get }
}