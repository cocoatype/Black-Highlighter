//  Created by Geoff Pado on 12/5/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Logging
import Tools
import UIKit

struct PhotoEditingWorkspaceViewTelemetryEventFactory {
    private static let eventName = Event.Name("PhotoEditingWorkspaceView.strokeCompleted")
    private static let toolKey = "tool"
    private static let colorKey = "color"
    func event(tool: HighlighterTool, color: UIColor) -> Event {
        var info = [Self.toolKey: value(for: tool)]
        if tool.logsColor {
            info[Self.colorKey] = value(for: color)
        }

        return Event(name: Self.eventName, info: info)
    }

    private func value(for tool: HighlighterTool) -> String {
        switch tool {
        case .magic: "magic"
        case .manual: "manual"
        case .eraser: "eraser"
        }
    }

    private func value(for color: UIColor) -> String {
        color.hexString
    }
}

fileprivate extension HighlighterTool {
    var logsColor: Bool {
        switch self {
        case .magic, .manual: true
        case .eraser: false
        }
    }
}
