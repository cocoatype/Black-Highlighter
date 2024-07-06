//  Created by Geoff Pado on 8/3/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

#if targetEnvironment(macCatalyst)
import AppKit
import UniformTypeIdentifiers

class ShareItem: NSSharingServicePickerToolbarItem, UIActivityItemsConfigurationReading {
    static let identifier = NSToolbarItem.Identifier("ShareItem.identifier")

    init(delegate: ShareItemDelegate?) {
        self.delegate = delegate
        super.init(itemIdentifier: Self.identifier)

        image = UIImage(systemName: "square.and.arrow.up")
        label = CoreStrings.ShareItem.label
        isEnabled = true

        activityItemsConfiguration = self
    }

    weak var delegate: ShareItemDelegate?

    var itemProvidersForActivityItemsConfiguration: [NSItemProvider] {
        guard let delegate = delegate, delegate.canExportImage else { return [] }

        let itemProvider = NSItemProvider()
        itemProvider.registerDataRepresentation(forTypeIdentifier: UTType.png.identifier, visibility: .all, loadHandler: { [weak self] loadHandler -> Progress? in
            Task { [weak self] in
                let image = await self?.delegate?.exportImage()
                loadHandler(image?.pngData(), nil)
                self?.delegate?.didExportImage()
            }
            return nil
        })

        return [itemProvider]
    }
}

protocol ShareItemDelegate: AnyObject {
    var canExportImage: Bool { get }
    func exportImage() async -> UIImage?
    func didExportImage()
}
#endif
