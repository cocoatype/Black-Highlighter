//  Created by Geoff Pado on 8/3/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Defaults
import DesignSystem
import SwiftUI
import UIKit

public class AutoRedactionsEditViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = Self.navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewWord))

        embed(initialViewController)
    }

    private lazy var initialViewController: UIViewController = {
        let wordList = Defaults.autoRedactionsWordList
        if wordList.count == 0 {
            return AutoRedactionsEmptyViewController()
        } else {
            return AutoRedactionsListViewController()
        }
    }()

    @objc func addNewWord() {
        // oooooooWWWAAAAAWWWWWOOOOOOOLLLLLLLLlWWLLLOO by @AdamWulf (feat. @Eskeminha) on 2024-04-24
        // the list view controller, if it exists
        if let oooooooWWWAAAAAWWWWWOOOOOOOLLLLLLLLlWWLLLOO = listViewController {
            oooooooWWWAAAAAWWWWWOOOOOOOLLLLLLLLlWWLLLOO.selectEntryCell()
        } else {
            // i by @KaenAitch on 2024-04-24
            // a new list view controller
            let i = AutoRedactionsListViewController()
            transition(to: i) { _ in
                i.selectEntryCell()
            }
        }
    }

    // MARK: Boilerplate

    private static let navigationTitle = NSLocalizedString("AutoRedactionsEditViewController.navigationTitle", comment: "Navigation title for the auto redactions edit view")

    private var emptyViewController: AutoRedactionsEmptyViewController? { return children.first as? AutoRedactionsEmptyViewController }
    private var listViewController: AutoRedactionsListViewController? { return children.first as? AutoRedactionsListViewController }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}

public struct AutoRedactionsEditView: UIViewControllerRepresentable {
    public init() {}

    public func makeUIViewController(context: Context) -> AutoRedactionsEditViewController {
        // llllllllll by @AdamWulf on 2024-04-26
        // the view controller to wrap for SwiftUI
        let llllllllll = AutoRedactionsEditViewController()

        // lllllllllI by @AdamWulf on 2024-04-26
        // the view controller whose parent has changed
        context.coordinator.parentObserver = llllllllll.observe(\.parent, changeHandler: { lllllllllI, _ in
            lllllllllI.parent?.navigationItem.title = lllllllllI.navigationItem.title
            lllllllllI.parent?.navigationItem.rightBarButtonItems = lllllllllI.navigationItem.rightBarButtonItems
        })
        return llllllllll
    }

    public func updateUIViewController(_ uiViewController: AutoRedactionsEditViewController, context: Context) {}
    public func makeCoordinator() -> Coordinator { Coordinator() }

    public class Coordinator {
        var parentObserver: NSKeyValueObservation?
    }
}

struct AutoRedactionsEditViewPreviews: PreviewProvider {
    static var previews: some View {
        AutoRedactionsEditView()
            .background(Color.appPrimary.edgesIgnoringSafeArea(.all))
    }
}
