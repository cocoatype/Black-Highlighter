// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum PhotoAsset {
  public static let accentColor = PhotoColors(name: "Accent Color")
  public static let albums = PhotoImages(name: "Albums")
  public static let brushEnd = PhotoImages(name: "Brush End")
  public static let brushStart = PhotoImages(name: "Brush Start")
  public static let brush = PhotoImages(name: "Brush")
  public static let favoritesAlbum = PhotoImages(name: "Favorites Album")
  public static let help = PhotoImages(name: "Help")
  public static let highlight = PhotoColors(name: "Highlight")
  public static let scanner = PhotoImages(name: "Scanner")
  public static let seek = PhotoImages(name: "Seek")
  public static let shortcuts = PhotoImages(name: "Shortcuts")
  public static let support = PhotoImages(name: "Support")
  public static let systems = PhotoImages(name: "Systems")
  public static let magicHighlighter = PhotoImages(name: "Magic Highlighter")
  public static let debigulator = PhotoImages(name: "Debigulator")
  public static let kineo = PhotoImages(name: "Kineo")
  public static let scrawl = PhotoImages(name: "Scrawl")
  public static let recentsAlbum = PhotoImages(name: "Recents Album")
  public static let redo = PhotoImages(name: "Redo")
  public static let screenshotsAlbum = PhotoImages(name: "Screenshots Album")
  public static let seekBoxInnerBorder = PhotoColors(name: "Seek Box Inner Border")
  public static let seekBoxOuterBorder = PhotoColors(name: "Seek Box Outer Border")
  public static let standardHighlighter = PhotoImages(name: "Standard Highlighter")
  public static let undo = PhotoImages(name: "Undo")
  public static let webTintColor = PhotoColors(name: "Web Tint Color")
  public static let highlighterEraser = PhotoImages(name: "highlighter.eraser")
  public static let highlighterMagic = PhotoImages(name: "highlighter.magic")
  public static let highlighterManual = PhotoImages(name: "highlighter.manual")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class PhotoColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension PhotoColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: PhotoColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: PhotoColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct PhotoImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: PhotoImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: PhotoImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: PhotoImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
