//  Created by Geoff Pado on 4/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Photos
import UIKit

class PhotoEditingViewController: UIViewController, UIScrollViewDelegate {
    init(asset: PHAsset) {
        self.asset = asset
        super.init(nibName: nil, bundle: nil)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(AppViewController.dismissPhotoEditingViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(PhotoEditingViewController.sharePhoto))
        updateToolbarItems(animated: false)

        redactionChangeObserver = NotificationCenter.default.addObserver(forName: PhotoEditingRedactionView.redactionsDidChange, object: nil, queue: .main, using: { [weak self] _ in
            self?.updateToolbarItems()
        })
    }

    override func loadView() {
        view = PhotoEditingScrollView()
        photoScrollView?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let options = PHImageRequestOptions()
        options.version = .current
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true

        imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options) { [weak self] image, info in
            let isDegraded = (info?[PHImageResultIsDegradedKey] as? NSNumber)?.boolValue ?? false
            guard let image = image, isDegraded == false else { return }

            self?.textRectangleDetector.detectTextRectangles(in: image) { (textObservations) in
                DispatchQueue.main.async { [weak self] in
                    self?.photoScrollView?.textObservations = textObservations
                }
            }

            DispatchQueue.main.async { [weak self] in
                self?.photoScrollView?.image = image
            }
        }
    }

    // MARK: Edit Protection

    private(set) var hasMadeEdits = false
    @objc func markHasMadeEdits() {
        hasMadeEdits = true
    }

    // MARK: Sharing

    @objc func sharePhoto() {
        guard let editingView = photoEditingView, let image = editingView.image else { return }
        let photoExporter = PhotoExporter(image: image, redactions: editingView.redactions)
        guard let exportedImage = photoExporter.exportedImage else { return }

        let activityController = UIActivityViewController(activityItems: [exportedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { [weak self] _, completed, _, _ in
            self?.hasMadeEdits = false
        }

        present(activityController, animated: true)
    }

    // MARK: Highlighters

    @objc func toggleHighlighterTool() {
        guard let currentTool = photoEditingView?.highlighterTool else { return }
        let allTools = HighlighterTool.allCases
        let currentToolIndex = allTools.firstIndex(of: currentTool) ?? allTools.startIndex
        let nextToolIndex = (currentToolIndex + 1) % allTools.count
        let nextTool = allTools[nextToolIndex]
        photoEditingView?.highlighterTool = nextTool
        updateToolbarItems()
    }

    private func updateToolbarItems(animated: Bool = true) {
        let undoToolItem = UIBarButtonItem(image: UIImage(named: "Undo"), style: .plain, target: self, action: #selector(PhotoEditingViewController.undo))
        undoToolItem.isEnabled = editingUndoManager.canUndo

        let redoToolItem = UIBarButtonItem(image: UIImage(named: "Redo"), style: .plain, target: self, action: #selector(PhotoEditingViewController.redo))
        redoToolItem.isEnabled = editingUndoManager.canRedo

        let spacerItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let highlighterToolIcon = photoEditingView?.highlighterTool.image
        let highlighterToolItem = UIBarButtonItem(image: highlighterToolIcon, style: .plain, target: self, action: #selector(toggleHighlighterTool))
        setToolbarItems([undoToolItem, redoToolItem, spacerItem, highlighterToolItem], animated: animated)
    }

    // MARK: Undo/Redo

    let editingUndoManager = UndoManager()
    override var undoManager: UndoManager? {
        return editingUndoManager
    }

    @objc private func undo() {
        editingUndoManager.undo()
        updateToolbarItems()
    }

    @objc private func redo() {
        editingUndoManager.redo()
        updateToolbarItems()
    }

    // MARK: UIScrollViewDelegate

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoEditingView
    }

    // MARK: Boilerplate

    private let asset: PHAsset
    private let imageManager = PHImageManager()
    private let textRectangleDetector = TextRectangleDetector()
    private var photoScrollView: PhotoEditingScrollView? { return (view as? PhotoEditingScrollView) }
    private var photoEditingView: PhotoEditingView? { return photoScrollView?.photoEditingView }
    private var redactionChangeObserver: Any?

    deinit {
        redactionChangeObserver.map(NotificationCenter.default.removeObserver)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
