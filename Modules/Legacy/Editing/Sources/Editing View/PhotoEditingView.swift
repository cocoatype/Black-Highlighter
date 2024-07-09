//  Created by Geoff Pado on 5/27/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Observations
import Redactions
import Tools
import UIKit

public class PhotoEditingView: UIView, UIScrollViewDelegate {
    public init() {
        super.init(frame: .zero)
        backgroundColor = .appBackground

        photoScrollView.delegate = self
        addSubview(photoScrollView)

        NSLayoutConstraint.activate([
            photoScrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            photoScrollView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            photoScrollView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            photoScrollView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    public var color: UIColor {
        get { return workspaceView.color }
        set(newColor) { workspaceView.color = newColor }
    }

    public var image: UIImage? {
        get { return photoScrollView.image }
        set(newImage) { photoScrollView.image = newImage }
    }

    public var textObservations: [TextRectangleObservation]? {
        didSet {
            photoScrollView.textObservations = textObservations
        }
    }

    var recognizedTextObservations: [RecognizedTextObservation]? {
        didSet {
            photoScrollView.recognizedTextObservations = recognizedTextObservations
            updateAccessibilityElements()
        }
    }

    var redactableCharacterObservations: [CharacterObservation] {
        photoScrollView.redactableCharacterObservations
    }

    public var highlighterTool: HighlighterTool {
        get { return workspaceView.highlighterTool }
        set(newTool) {
            workspaceView.highlighterTool = newTool
        }
    }

    public var redactions: [Redaction] {
        workspaceView.redactions
    }

    public func add(_ redactions: [Redaction]) {
        workspaceView.add(redactions)
    }

    func redact(_ observations: [any TextObservation], joinSiblings: Bool) {
        workspaceView.redact(observations, joinSiblings: joinSiblings)
        updateAccessibilityElements()
    }

    func unredact(_ observation: any TextObservation) {
        workspaceView.unredact(observation)
        updateAccessibilityElements()
    }

    var seekPreviewObservations: [CharacterObservation] {
        get { workspaceView.seekPreviewObservations }
        set(newTextObservations) {
            workspaceView.seekPreviewObservations = newTextObservations
        }
    }

    // MARK: UIScrollViewDelegate

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return workspaceView
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard scrollView == photoScrollView else { return }
        workspaceView.scrollViewDidZoom(to: scrollView.zoomScale)
    }

    // MARK: Accessibility

    private func updateAccessibilityElements() {
        let wordObservations = recognizedTextObservations?.flatMap(\.allWordObservations) ?? []
        let accessibilityElements = wordObservations.map { observation in
            WordObservationAccessibilityElement(observation, in: workspaceView) { [weak self] observation, isRedacted -> Bool in
                if isRedacted {
                    self?.unredact(observation)
                } else {
                    self?.redact([observation], joinSiblings: true)
                }

                return true
            }
        }

        workspaceView.accessibilityElements = accessibilityElements
        workspaceView.accessibilityCustomRotors = [RedactedWordObservationRotor(accessibilityElements: accessibilityElements)]
    }

    // MARK: Boilerplate

    private let photoScrollView = PhotoEditingScrollView()
    private var workspaceView: PhotoEditingWorkspaceView { photoScrollView.workspaceView }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
