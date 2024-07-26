//  Created by Geoff Pado on 7/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import XCTest

struct CallbackActionURLGenerator {
    func openURL(imageURL: URL) throws -> URL {
        try url(action: "open", imageURL: imageURL, successURL: nil)
    }

    func editURL(imageURL: URL, successURL: URL?) throws -> URL {
        try url(action: "edit", imageURL: imageURL, successURL: successURL)
    }

    // MARK: Intermediate Builders

    func url(action: String, imageURL: URL, successURL: URL?) throws -> URL {
        let imageString = try imageDataString(forImageAt: imageURL)
        var queryItems = [URLQueryItem(name: "imageData", value: imageString)]
        if let successURL {
            let encodedURL = try XCTUnwrap(successURL.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            queryItems.append(URLQueryItem(name: "x-success", value: encodedURL))
        }
        return try url(path: "/\(action)", queryItems: queryItems)
    }

    private func url(path: String, queryItems: [URLQueryItem]) throws -> URL {
        var components = try XCTUnwrap(URLComponents(string: "highlighter://x-callback-url"))
        components.path = path
        components.queryItems = queryItems
        return try XCTUnwrap(components.url)
    }

    private func imageDataString(forImageAt url: URL) throws -> String {
        let imageData = try XCTUnwrap(FileManager.default.contents(atPath: url.path))
        return imageData.base64EncodedString()
    }
}
