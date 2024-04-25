//  Created by Geoff Pado on 8/3/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Defaults
import Editing
import SwiftUI
import UIKit

class AutoRedactionsEditViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
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

    @objc func saveNewWord(_ sender: UITextField) {
        guard let string = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              string.isEmpty == false
        else { return }

        var existingWordList = Defaults.autoRedactionsWordList
        existingWordList.append(string)
        Defaults.autoRedactionsWordList = existingWordList

        sender.text = nil

        reloadRedactionsView()
    }

    @objc func reloadRedactionsView() {
        listViewController?.reloadListView()
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

public struct AutoRedactionsEditView: View {
    public init() {}

    public var body: some View {
        wrapper
            .navigationTitle("AutoRedactionsEditViewController.navigationTitle")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        wrapper.addNewWord()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    })
                }
            }
    }

    private let wrapper = AutoRedactionsEditViewControllerWrapper()
}

struct AutoRedactionsEditViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AutoRedactionsEditViewController {
        return controller
    }

    func updateUIViewController(_ uiViewController: AutoRedactionsEditViewController, context: Context) {}

    func addNewWord() {
        controller.addNewWord()
    }

    private let controller = AutoRedactionsEditViewController()
}

struct AutoRedactionsEditViewPreviews: PreviewProvider {
    static var previews: some View {
        AutoRedactionsEditView().background(Color.appPrimary.edgesIgnoringSafeArea(.all))
    }
}
