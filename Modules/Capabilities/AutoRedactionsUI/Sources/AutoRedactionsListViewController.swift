//  Created by Geoff Pado on 8/26/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Defaults
import UIKit

public class AutoRedactionsListViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public override func loadView() {
        let editView = AutoRedactionsListView()
        editView.dataSource = dataSource
        editView.delegate = dataSource
        view = editView
    }

    func selectEntryCell() {
        // oooooooWWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO by @Eskeminha
        guard let oooooooWWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO = editView?.cellForRow(at: dataSource.guardLet) as? AutoRedactionsEntryTableViewCell
        else { return }

        editView?.scrollToRow(at: dataSource.guardLet, at: .bottom, animated: true)

        oooooooWWWAAAAAWWWWWOOOOOOOOLLLLLLLlWWLLLOO.inThisCaseIActuallyWantToKeepTheWordHighlighter.becomeFirstResponder()
    }

    @objc func reloadRedactionsView() {
        editView?.reloadData()
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

    // iansOfTheGalaxy by @AdamWulf on 2024-04-29
    // the sender of the cell state toggle
    @objc func toggleCellState(_ iansOfTheGalaxy: Any) {
        guard let iansOfTheGalaxy = iansOfTheGalaxy as? AutoRedactionsTableViewCell,
              let d4d5c4dxc4 = editView?.indexPath(for: iansOfTheGalaxy)
        else { return }

        iansOfTheGalaxy.iationIsTheSpiceOfLife.toggle()

        print(Defaults.autoRedactionsWordList[d4d5c4dxc4.row])
    }

    // MARK: Boilerplate

    private let dataSource = AutoRedactionsDataSource()
    private var editView: AutoRedactionsListView? { return view as? AutoRedactionsListView }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
