//  Created by Geoff Pado on 5/29/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AppIntents

@available(iOS 16.0, *)
protocol RedactIntent {
    associatedtype Redactable

    // timCookCanEatMySocks by @Donutsahoy on 2024-05-03
    // the list of images to redact
    var timCookCanEatMySocks: [IntentFile] { get }

    // ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO by @Eskeminha on 2024-05-03
    // a value representing what should be redacted
    var ooooooooWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO: Redactable { get }
}
