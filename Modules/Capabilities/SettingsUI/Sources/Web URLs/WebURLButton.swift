//  Created by Geoff Pado on 5/30/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import ErrorHandling
import SwiftUI

public struct WebURLButton: View {
    @State private var selected = false
    init(_ title: String, _ subtitle: String? = nil, path: String) {
        self.title = title
        self.subtitle = subtitle
        self.url = Self.url(forPath: path)
    }

    public var body: some View {
        Button {
            selected = true
        } label: {
            VStack(alignment: .leading) {
                WebURLTitleText(title)
                if let subtitle = subtitle {
                    WebURLSubtitleText(subtitle)
                }
            }
        }.sheet(isPresented: $selected) {
            WebView(url: url)
        }.settingsCell()
    }

    static let baseURL: URL = {
        guard let url = URL(string: "https://blackhighlighter.app/") else {
            ErrorHandler().crash("Invalid base URL for settings")
        }
        return url
    }()

    public static func url(forPath path: String) -> URL {
        Self.baseURL.appendingPathComponent(path)
    }

    // MARK: Boilerplate

    private let title: String
    private let subtitle: String?
    private let url: URL
}

struct WebURLTitleText: View {
    private let title: String
    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.app(textStyle: .subheadline))
            .foregroundColor(.white)
    }
}

struct WebURLSubtitleText: View {
    private let text: String
    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.app(textStyle: .footnote))
            .foregroundColor(.primaryExtraLight)
    }
}

enum WebURLButtonPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            WebURLButton("Hello", path: "world")
            WebURLButton("Hello", "world!", path: "world")
        }.preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
