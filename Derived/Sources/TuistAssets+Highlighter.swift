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
public enum HighlighterAsset {
  public static let accentColor = HighlighterColors(name: "Accent Color")
  public static let albums = HighlighterImages(name: "Albums")
  public static let brushEnd = HighlighterImages(name: "Brush End")
  public static let brushStart = HighlighterImages(name: "Brush Start")
  public static let brush = HighlighterImages(name: "Brush")
  public static let favoritesAlbum = HighlighterImages(name: "Favorites Album")
  public static let help = HighlighterImages(name: "Help")
  public static let highlight = HighlighterColors(name: "Highlight")
  public static let scanner = HighlighterImages(name: "Scanner")
  public static let seek = HighlighterImages(name: "Seek")
  public static let shortcuts = HighlighterImages(name: "Shortcuts")
  public static let support = HighlighterImages(name: "Support")
  public static let systems = HighlighterImages(name: "Systems")
  public static let magicHighlighter = HighlighterImages(name: "Magic Highlighter")
  public static let debigulator = HighlighterImages(name: "Debigulator")
  public static let kineo = HighlighterImages(name: "Kineo")
  public static let scrawl = HighlighterImages(name: "Scrawl")
  public static let recentsAlbum = HighlighterImages(name: "Recents Album")
  public static let redo = HighlighterImages(name: "Redo")
  public static let screenshotsAlbum = HighlighterImages(name: "Screenshots Album")
  public static let seekBoxInnerBorder = HighlighterColors(name: "Seek Box Inner Border")
  public static let seekBoxOuterBorder = HighlighterColors(name: "Seek Box Outer Border")
  public static let standardHighlighter = HighlighterImages(name: "Standard Highlighter")
  public static let undo = HighlighterImages(name: "Undo")
  public static let webTintColor = HighlighterColors(name: "Web Tint Color")
  public static let highlighterEraser = HighlighterImages(name: "highlighter.eraser")
  public static let highlighterMagic = HighlighterImages(name: "highlighter.magic")
  public static let highlighterManual = HighlighterImages(name: "highlighter.manual")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class HighlighterColors {
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

public extension HighlighterColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: HighlighterColors) {
    let bundle = HighlighterResources.bundle
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
  init(asset: HighlighterColors) {
    let bundle = HighlighterResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct HighlighterImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = HighlighterResources.bundle
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
  init(asset: HighlighterImages) {
    let bundle = HighlighterResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: HighlighterImages, label: Text) {
    let bundle = HighlighterResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: HighlighterImages) {
    let bundle = HighlighterResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
