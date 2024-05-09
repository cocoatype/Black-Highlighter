//  Created by Geoff Pado on 5/8/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public typealias RedactionColor = NSColor
public typealias RedactionPath = NSBezierPath
#elseif canImport(UIKit)
import UIKit

public typealias RedactionColor = UIColor
public typealias RedactionPath = UIBezierPath
#endif
