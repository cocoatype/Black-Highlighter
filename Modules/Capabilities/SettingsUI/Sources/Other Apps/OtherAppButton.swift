//  Created by Geoff Pado on 5/19/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import SwiftUI

struct OtherAppButton: View {
    private let name: String
    private let subtitle: String
    private let id: String

    init(name: String, subtitle: String, id: String) {
        self.name = name
        self.subtitle = subtitle
        self.id = id
    }

    private var url: URL {
        let urlString = "https://apps.apple.com/us/app/cocoatype/id\(id)?uo=4"
        guard let url = URL(string: urlString) else { ErrorHandler().crash("Invalid App Store URL: \(urlString)") }
        return url
    }

    var body: some View {
        Button {
            UIApplication.shared.open(url)
        } label: {
            ButtonLabel(title: name, subtitle: subtitle, imageName: name)
        }.settingsCell()
    }
}

enum OtherAppButton_Previews: PreviewProvider {
    static var previews: some View {
        OtherAppButton(name: "Kineo", subtitle: "Create flipbook-style animations", id: "286948844").preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
