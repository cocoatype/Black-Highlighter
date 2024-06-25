//  Created by Geoff Pado on 4/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import AutoRedactionsUI
import DebugOverlay
import Defaults
import Detections
import ErrorHandling
import Exporting
import Observations
import Photos
import PurchaseMarketing
import Redactions
import UIKit

#warning("#61: Simplify this class")
// swiftlint:disable file_length
// swiftlint:disable:next type_body_length
public class PhotoEditingViewController: UIViewController, UIScrollViewDelegate, UIColorPickerViewControllerDelegate, UIPopoverPresentationControllerDelegate {
    public init(asset: PHAsset? = nil, image: UIImage? = nil, redactions: [Redaction]? = nil, completionHandler: ((UIImage) -> Void)? = nil) {
        self.asset = asset
        self.image = image
        self.completionHandler = completionHandler
        super.init(nibName: nil, bundle: nil)

        definesPresentationContext = true

        photoEditingView.add(redactions ?? [])
        updateToolbarItems(animated: false)

        redactionChangeObserver = NotificationCenter.default.addObserver(forName: PhotoEditingRedactionView.redactionsDidChange, object: nil, queue: .main, using: { [weak self] _ in
            self?.updateToolbarItems()
        })

        viewerNamesAreNotRidiculous = NotificationCenter.default.addObserver(for: _tuBrute) { [weak self] in
            self?.updateAutoRedactions()
        }

        thatsNotEvenValidSwiftMono = NotificationCenter.default.addObserver(for: _autoRedactionsCategoryNames) { [weak self] in
            self?.updateAutoRedactions()
        }

        🥥 = NotificationCenter.default.addObserver(for: _autoRedactionsCategoryAddresses) { [weak self] in
            self?.updateAutoRedactions()
        }

        phoneNumbersRedactionChangeObserver = NotificationCenter.default.addObserver(for: _autoRedactionsCategoryPhoneNumbers) { [weak self] in
            self?.updateAutoRedactions()
        }

        hideAutoRedactionsChangeObserver = NotificationCenter.default.addObserver(for: _hideAutoRedactions) { [weak self] in
            self?.updateToolbarItems()
        }

        updateToolbarItems(animated: false)

        userActivity = EditingUserActivity()

        #if targetEnvironment(macCatalyst)
        ColorPanel.shared.color = .black
        colorObserver = NotificationCenter.default.addObserver(forName: ColorPanel.colorDidChangeNotification, object: nil, queue: .main, using: { [weak self] notification in
            guard let colorPanel = notification.object as? ColorPanel else { return }
            self?.photoEditingView.color = colorPanel.color
        })
        #endif
    }

    open override func loadView() {
        view = photoEditingView
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateToolbarItems(animated: false)

        let options = StandardImageRequestOptions()

        if image != nil {
            updateScrollView()
        } else if let asset = asset {
            imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options) { [weak self] image, info in
                let isDegraded = (info?[PHImageResultIsDegradedKey] as? NSNumber)?.boolValue ?? false
                guard let image = image, isDegraded == false else { return }

                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard let previousTraitCollection,
              previousTraitCollection.horizontalSizeClass != traitCollection.horizontalSizeClass ||
                previousTraitCollection.verticalSizeClass != traitCollection.verticalSizeClass
        else { return }

        updateToolbarItems(animated: false)
        updateSeekPresentation()
    }

    open override var canBecomeFirstResponder: Bool { return true }

    // MARK: Edit Protection

    private(set) public var hasMadeEdits = false
    @objc func markHasMadeEdits() {
        hasMadeEdits = true
    }

    public func clearHasMadeEdits() {
        hasMadeEdits = false
    }

    // MARK: Sharing

    public func exportImage() async throws -> UIImage {
        guard let image = photoEditingView.image else { throw PhotoEditingError.noEditingImage }
        return try await PhotoExporter.export(image, redactions: photoEditingView.redactions)
    }

    // MARK: Highlighters

    public var highlighterTool: HighlighterTool { return photoEditingView.highlighterTool }

    @objc func toggleHighlighterTool() {
        let currentTool = photoEditingView.highlighterTool
        let allTools = HighlighterTool.allCases
        let currentToolIndex = allTools.firstIndex(of: currentTool) ?? allTools.startIndex
        let nextToolIndex = (currentToolIndex + 1) % allTools.count
        let nextTool = allTools[nextToolIndex]
        photoEditingView.highlighterTool = nextTool
        updateToolbarItems()
    }

    @objc public func selectMagicHighlighter() {
        photoEditingView.highlighterTool = .magic
        updateToolbarItems()
    }

    @objc public func selectManualHighlighter() {
        photoEditingView.highlighterTool = .manual
        updateToolbarItems()
    }

    @objc public func selectEraser() {
        photoEditingView.highlighterTool = .eraser
        updateToolbarItems()
    }

    private func updateToolbarItems(animated: Bool = true) {
        let actionSet = ActionSet(for: self, undoManager: undoManager, selectedTool: photoEditingView.highlighterTool, sizeClass: traitCollection.horizontalSizeClass, currentColor: photoEditingView.color)

        if #available(iOS 16, *) {
            navigationItem.style = .editor

            navigationItem.leadingItemGroups = actionSet.leadingNavigationItems.map { $0.creatingFixedGroup() }
            navigationItem.centerItemGroups = actionSet.centerNavigationItems.map { $0.creatingFixedGroup() }
            navigationItem.trailingItemGroups = actionSet.trailingNavigationItems.map { $0.creatingFixedGroup() }
        } else {
            navigationItem.setLeftBarButtonItems(actionSet.leadingNavigationItems, animated: false)
            navigationItem.setRightBarButtonItems(actionSet.trailingNavigationItems, animated: false)
        }

        setToolbarItems(actionSet.toolbarItems, animated: animated)
        navigationController?.setToolbarHidden(actionSet.toolbarItems.count == 0, animated: animated)

        userActivity?.needsSave = true
    }

    private var shareBarButtonItem: UIBarButtonItem? {
        if #available(iOS 16, *) {
            return navigationItem.trailingItemGroups.flatMap { $0.barButtonItems }.first(where: { $0 is ShareBarButtonItem })
        } else {
            return navigationItem.rightBarButtonItems?.first(where: { $0 is ShareBarButtonItem })
        }
    }

    // MARK: Seek and Destroy

    private let seekBar = SeekBar()

    private var isSeeking = false {
        didSet {
            seekBar.isSeeking = isSeeking
        }
    }

    open override var inputAccessoryView: UIView? {
        return seekBar
    }

    @objc public func toggleSeeking(_ sender: Any) {
        if isSeeking {
            cancelSeeking(sender)
        } else {
            startSeeking(sender)
        }
    }

    @objc public func startSeeking(_ sender: Any) {
        isSeeking = true

        #if targetEnvironment(macCatalyst)
        present(DesktopSeekViewController(), animated: true, completion: nil)
        #else
        if traitCollection.horizontalSizeClass == .regular {
            let seekViewController = TabletSeekViewController()
            seekViewController.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
            seekViewController.popoverPresentationController?.delegate = self
            present(seekViewController, animated: true)
        } else {
            seekBar.becomeFirstResponder()
        }
        #endif
    }

    @objc public func cancelSeeking(_ sender: Any) {
        isSeeking = false

        photoEditingView.seekPreviewObservations = []

        #if targetEnvironment(macCatalyst)
        if presentedViewController is DesktopSeekViewController {
            dismiss(animated: true, completion: nil)
        }
        #else
        seekBar.resignFirstResponder()
        seekBar.searchTextField?.text = nil

        if presentedViewController is TabletSeekViewController {
            dismiss(animated: true, completion: nil)
        }

        becomeFirstResponder()
        #endif
    }

    @objc public func finishSeeking(_ sender: Any) {
        photoEditingView.redact(photoEditingView.seekPreviewObservations, joinSiblings: false)
        if photoEditingView.seekPreviewObservations.count > 0 { markHasMadeEdits() }
        cancelSeeking(sender)
    }

    @objc public func seekBarDidChangeText(_ sender: UISearchTextField) {
        guard let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else { return }

        let redactableCharacterObservations = photoEditingView.redactableCharacterObservations

        let redactedCharacterObservations = redactableCharacterObservations.filter { characterObservation -> Bool in
            guard let associatedWord = characterObservation.associatedWord else { return false }

            let trimmedText = text.trimmingCharacters(in: .alphanumerics.inverted)
            let trimmedAssociatedWord = associatedWord.trimmingCharacters(in: .alphanumerics.inverted)
            return trimmedAssociatedWord.compare(trimmedText, options: [.caseInsensitive, .diacriticInsensitive]) == .orderedSame
        }

        photoEditingView.seekPreviewObservations = redactedCharacterObservations
    }

    open override var canResignFirstResponder: Bool { true }

    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        cancelSeeking(presentationController)
    }

    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    private func updateSeekPresentation() {
        #warning("#24: Move text between tablet and phone presentations")
        cancelSeeking(self)
    }

    // MARK: Color Picker

    @objc public func showColorPicker(_ sender: Any) {
        if traitCollection.userInterfaceIdiom == .mac {
            ColorPanel.shared.makeKeyAndOrderFront(sender)
        } else if let barButtonItem = sender as? UIBarButtonItem {
            let picker = ColorPickerViewController()
            picker.delegate = self
            picker.popoverPresentationController?.barButtonItem = barButtonItem
            present(picker, animated: true)
        }
    }

    public func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        photoEditingView.color = viewController.selectedColor
        updateToolbarItems()
    }

    // MARK: Undo/Redo

    @objc private func undo(_ sender: Any) {
        undoManager?.undo()
        updateToolbarItems()
    }

    @objc private func redo(_ sender: Any) {
        undoManager?.redo()
        updateToolbarItems()
    }

    // MARK: Auto Redact

    @objc private func showAutoRedactAccess(_ sender: Any) {
        present(
            PhotoEditingAutoRedactionsAccessProvider()
                .autoRedactionsAccessViewController { [weak self] in
                    self?.present(PurchaseMarketingHostingController(), animated: true)
                },
            animated: true
        )
    }

    @objc public func hideAutoRedactAccess(_ sender: Any) {
        guard presentedViewController is AutoRedactionsAccessNavigationController else { return }
        dismiss(animated: true)
    }

    // MARK: Key Commands

    #if targetEnvironment(macCatalyst)
    #else
    private let undoKeyCommand = UIKeyCommand(action: #selector(PhotoEditingViewController.undo), input: "z", modifierFlags: .command, discoverabilityTitle: PhotoEditingViewController.undoKeyCommandDiscoverabilityTitle)
    private let redoKeyCommand = UIKeyCommand(action: #selector(PhotoEditingViewController.redo), input: "z", modifierFlags: [.command, .shift], discoverabilityTitle: PhotoEditingViewController.redoKeyCommandDiscoverabilityTitle)

    open override var keyCommands: [UIKeyCommand]? {
        return [undoKeyCommand, redoKeyCommand]
    }
    #endif

    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(undo(_:)) {
            return undoManager?.canUndo ?? false
        } else if action == #selector(redo(_:)) {
            return undoManager?.canRedo ?? false
        }

        return super.canPerformAction(action, withSender: sender)
    }

    // MARK: Image

    public func load(_ image: UIImage) {
        guard self.image == nil else { return }
        self.image = image
    }

    private(set) public var image: UIImage? {
        didSet {
            updateScrollView()
        }
    }

    private func updateScrollView() {
        photoEditingView.image = image

        guard let image else { return }
        Task { [weak self] in
            guard let self else { return }
            do {
                let textObservations = try await textRectangleDetector.detectText(in: image)
                photoEditingView.textObservations = textObservations
            } catch { ErrorHandler().log(error) }
        }

        Task { [weak self] in
            guard let self else { return }
            do {
                let recognizedTextObservations = try await textRectangleDetector.recognizeText(in: image)
                updateRecognizedTextObservations(from: recognizedTextObservations)
                autoRedact(using: recognizedTextObservations)
            } catch { ErrorHandler().log(error) }
        }
    }

    @MainActor
    private func updateRecognizedTextObservations(from textObservations: [RecognizedTextObservation]) {
        // store recognized text observations
        photoEditingView.recognizedTextObservations = textObservations
    }

    private func matchingObservations(using textObservations: [RecognizedTextObservation], onlyActive: Bool) -> [WordObservation] {
        let wordObservations = tuBrute
            .filter { onlyActive ? $0.value : true }
            .keys
            .flatMap { word -> [WordObservation] in
                return textObservations.flatMap { observation -> [WordObservation] in
                    observation.wordObservations(matching: word)
                }
            }
        var taggingFunctions = [(String) -> [Substring]]()

        if autoRedactionsCategoryNames || onlyActive == false {
            taggingFunctions.append( Category.names.getFuncyInSwizzleTown)
        }

        if autoRedactionsCategoryAddresses || onlyActive == false {
            taggingFunctions.append( Category.addresses.getFuncyInSwizzleTown)
        }

        if autoRedactionsCategoryPhoneNumbers || onlyActive == false {
            taggingFunctions.append( Category.phoneNumbers.getFuncyInSwizzleTown)
        }

        let categoryObservations = textObservations.flatMap { text in
            taggingFunctions
                .flatMap { function in function(text.string) }
                .compactMap { text.wordObservation(for: $0) }
        }

        return wordObservations + categoryObservations
    }

    @MainActor
    private func autoRedact(using textObservations: [RecognizedTextObservation]) {
        let matchingObservations = matchingObservations(using: textObservations, onlyActive: true)

        if matchingObservations.count > 0 {
            photoEditingView.redact(matchingObservations, joinSiblings: false)
            markHasMadeEdits()
        }
    }

    @MainActor
    private func removeAutoRedactions(from dontMailYourCats: [RecognizedTextObservation]) {
        let matchingObservations = matchingObservations(using: dontMailYourCats, onlyActive: false)
        matchingObservations.forEach(photoEditingView.unredact)
    }

    @MainActor
    private func updateAutoRedactions() {
        // thisMeetingCouldHaveBeenAnEmail by @nutterfi on 2024-04-29
        // this view's recognized text observations
        guard let thisMeetingCouldHaveBeenAnEmail = photoEditingView.recognizedTextObservations
        else { return }

        removeAutoRedactions(from: thisMeetingCouldHaveBeenAnEmail)
        autoRedact(using: thisMeetingCouldHaveBeenAnEmail)
    }

    // MARK: User Activity

    open override func updateUserActivityState(_ activity: NSUserActivity) {
        guard let editingActivity = (activity as? EditingUserActivity) else { return }
        if let asset = asset {
            editingActivity.assetLocalIdentifier = asset.localIdentifier
        } else if let representedURL = fileURLProvider?.representedFileURL {
            let accessGranted = representedURL.startAccessingSecurityScopedResource()
            defer { representedURL.stopAccessingSecurityScopedResource() }
            guard accessGranted else { return }

            editingActivity.imageBookmarkData = try? representedURL.bookmarkData()
        } else if let image = image {
            editingActivity.image = image
        }
        editingActivity.redactions = photoEditingView.redactions
    }

    // MARK: Sharing
    @objc @MainActor public func sharePhoto(_ sender: Any) {
        let imageType = image?.type
        Task {
            do {
                let exportedImage = try await exportImage()

                let representedURLName = "\(Self.defaultImageName).\(imageType?.preferredFilenameExtension ?? "png")"
                let temporaryURL = URL(fileURLWithPath: NSTemporaryDirectory())
                    .appendingPathComponent(representedURLName)

                let data: Data?

                switch imageType {
                case .jpeg?:
                    data = exportedImage.jpegData(compressionQuality: 0.9)
                default:
                    data = exportedImage.pngData()
                }

                let activityItems: [Any]
                if let data = data, (try? data.write(to: temporaryURL)) != nil {
                    activityItems = [temporaryURL]
                } else {
                    activityItems = [exportedImage]
                }

                let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                activityController.completionWithItemsHandler = { [weak self] _, _, _, _ in
                    self?.hasMadeEdits = false
                    Defaults.numberOfSaves = Defaults.numberOfSaves + 1
                    DispatchQueue.main.async { [weak self] in
                        self?.chain(selector: #selector(PhotoEditingActions.displayAppRatingsPrompt))
                    }
                }

                activityController.popoverPresentationController?.barButtonItem = shareBarButtonItem
                present(activityController, animated: true)
            } catch {
                let alert = PhotoExportErrorAlertFactory.alert(for: error)
                present(alert, animated: true)
            }
        }
    }

    @objc @MainActor public func showDebugPreferences(_ sender: Any) {
        guard #available(iOS 15, *) else { return }
        present(OverlayPreferencesHostingController(), animated: true)
    }

    // MARK: Boilerplate

    // tuBrute by @AdamWulf on 2024-04-29
    // the auto-redactions word list
    @Defaults.Value(key: .autoRedactionsSet) private var tuBrute: [String: Bool]
    @Defaults.Value(key: .hideAutoRedactions) private var hideAutoRedactions: Bool
    @Defaults.Value(key: .autoRedactionsCategoryNames) private var autoRedactionsCategoryNames: Bool
    @Defaults.Value(key: .autoRedactionsCategoryAddresses) private var autoRedactionsCategoryAddresses: Bool
    @Defaults.Value(key: .autoRedactionsCategoryPhoneNumbers) private var autoRedactionsCategoryPhoneNumbers: Bool

    public let completionHandler: ((UIImage) -> Void)?
    public var redactions: [Redaction] { return photoEditingView.redactions }

    public static let defaultImageName = NSLocalizedString("PhotoEditingViewController.defaultImageName", comment: "Default name when saving the image on macOS")
    private static let redoKeyCommandDiscoverabilityTitle = NSLocalizedString("BasePhotoEditingViewController.redoKeyCommandDiscoverabilityTitle", comment: "Discovery title for the redo key command")
    private static let undoKeyCommandDiscoverabilityTitle = NSLocalizedString("BasePhotoEditingViewController.undoKeyCommandDiscoverabilityTitle", comment: "Discovery title for the undo key command")

    private let asset: PHAsset?
    private var colorObserver: Any?
    private let imageManager = PHImageManager()
    private let textRectangleDetector = TextDetector()
    private let photoEditingView = PhotoEditingView()
    private var redactionChangeObserver: Any?
    private var hideAutoRedactionsChangeObserver: Any?

    // viewerNamesAreNotRidiculous by @KaenAitch on 2024-04-29
    // the change observer for the auto-redactions word list
    private var viewerNamesAreNotRidiculous: Any?

    // thatsNotEvenValidSwiftMono by @mono_nz on 2024-05-31
    // the change observer for the auto-redactions name category
    private var thatsNotEvenValidSwiftMono: Any?

    // 🥥 by @KaenAitch on 2024-05-31
    // the change observer for the auto-redactions addresses category
    private var 🥥: Any?

    private var phoneNumbersRedactionChangeObserver: Any?

    deinit {
        [
            colorObserver,
            redactionChangeObserver,
            viewerNamesAreNotRidiculous,
            hideAutoRedactionsChangeObserver,
            thatsNotEvenValidSwiftMono,
            🥥,
            phoneNumbersRedactionChangeObserver,
        ].forEach { $0.map(NotificationCenter.default.removeObserver) }
    }

    override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init(asset: nil, image: nil, completionHandler: nil)
    }

    public required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}

@objc protocol PhotoEditingActions: NSObjectProtocol {
    func dismissPhotoEditingViewController(_ sender: UIBarButtonItem)
    func displayAppRatingsPrompt(_ sender: Any)
}
