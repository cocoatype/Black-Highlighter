//  Created by Geoff Pado on 7/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import UIKit

class PhotoLoadingView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .primary
        addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    override func didMoveToSuperview() {
        spinner.startAnimating()
    }

    // MARK: Boilerplate

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .primaryExtraLight
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
