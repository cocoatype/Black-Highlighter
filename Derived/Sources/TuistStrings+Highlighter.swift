// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum HighlighterStrings {

  public enum AlbumsBarButtonItem {
  /// Albums
    public static let standardAccessibilityLabel = HighlighterStrings.tr("Localizable", "AlbumsBarButtonItem.standardAccessibilityLabel")
  }

  public enum AlbumsViewController {
  /// Albums
    public static let navigationTitle = HighlighterStrings.tr("Localizable", "AlbumsViewController.navigationTitle")
  }

  public enum AppDelegate {
  /// Preferences…
    public static let preferencesMenuItemTitle = HighlighterStrings.tr("Localizable", "AppDelegate.preferencesMenuItemTitle")
    /// Preferences
    public static let preferencesMenuTitle = HighlighterStrings.tr("Localizable", "AppDelegate.preferencesMenuTitle")
    /// Save As…
    public static let saveAsMenuTitle = HighlighterStrings.tr("Localizable", "AppDelegate.saveAsMenuTitle")
    /// Save
    public static let saveMenuTitle = HighlighterStrings.tr("Localizable", "AppDelegate.saveMenuTitle")
  }

  public enum AssetPhotoLibraryViewCell {
  /// Photo, %@
    public static func accessibilityLabelFormat(_ p1: Any) -> String {
      return HighlighterStrings.tr("Localizable", "AssetPhotoLibraryViewCell.accessibilityLabelFormat%@",String(describing: p1))
    }
  }

  public enum AutoRedactionsAdditionDialogFactory {
  /// Add Word
    public static let addButtonTitle = HighlighterStrings.tr("Localizable", "AutoRedactionsAdditionDialogFactory.addButtonTitle")
    /// Auto-Hide Word
    public static let dialogTitle = HighlighterStrings.tr("Localizable", "AutoRedactionsAdditionDialogFactory.dialogTitle")
    /// Hidden Word
    public static let placeholder = HighlighterStrings.tr("Localizable", "AutoRedactionsAdditionDialogFactory.placeholder")
  }

  public enum AutoRedactionsDataSource {
  /// Delete
    public static let deleteActionTitle = HighlighterStrings.tr("Localizable", "AutoRedactionsDataSource.deleteActionTitle")
  }

  public enum AutoRedactionsEditViewController {
  /// Auto-Hidden Words
    public static let navigationTitle = HighlighterStrings.tr("Localizable", "AutoRedactionsEditViewController.navigationTitle")
  }

  public enum AutoRedactionsEmptyView {
  /// Add Word
    public static let promptButtonTitle = HighlighterStrings.tr("Localizable", "AutoRedactionsEmptyView.promptButtonTitle")
    /// Add words to this list to automatically hide them when opening images.
    public static let promptLabelText = HighlighterStrings.tr("Localizable", "AutoRedactionsEmptyView.promptLabelText")
  }

  public enum AutoRedactionsEntryTableViewCellField {
  /// Add Word…
    public static let placeholder = HighlighterStrings.tr("Localizable", "AutoRedactionsEntryTableViewCellField.placeholder")
  }

  public enum BasePhotoEditingViewController {
  /// Redo Redaction
    public static let redoKeyCommandDiscoverabilityTitle = HighlighterStrings.tr("Localizable", "BasePhotoEditingViewController.redoKeyCommandDiscoverabilityTitle")
    /// Undo Redaction
    public static let undoKeyCommandDiscoverabilityTitle = HighlighterStrings.tr("Localizable", "BasePhotoEditingViewController.undoKeyCommandDiscoverabilityTitle")
  }

  public enum CollectionsDataSource {
  /// Library
    public static let smartAlbumsHeader = HighlighterStrings.tr("Localizable", "CollectionsDataSource.smartAlbumsHeader")
    /// Albums
    public static let userAlbumsHeader = HighlighterStrings.tr("Localizable", "CollectionsDataSource.userAlbumsHeader")
  }

  public enum ColorPickerBarButtonItem {
  /// Color Picker
    public static let accessibilityLabel = HighlighterStrings.tr("Localizable", "ColorPickerBarButtonItem.accessibilityLabel")
  }

  public enum ContactMailViewController {
  /// Hello!
    public static let emailSubject = HighlighterStrings.tr("Localizable", "ContactMailViewController.emailSubject")
  }

  public enum DesktopSaveAlertController {
  /// OK
    public static let dismissButtonTitle = HighlighterStrings.tr("Localizable", "DesktopSaveAlertController.dismissButtonTitle")
  }

  public enum DesktopSaveError {
  /// There was an unexpected error when saving the image. If this continues to happen, please contact support at hello@cocoatype.com.
    public static let alertMessage = HighlighterStrings.tr("Localizable", "DesktopSaveError.alertMessage")

    public enum MissingImageType {
    /// Unknown Image Type
      public static let alertTitle = HighlighterStrings.tr("Localizable", "DesktopSaveError.missingImageType.alertTitle")
    }

    public enum MissingRepresentedURL {
    /// Invalid Image
      public static let alertTitle = HighlighterStrings.tr("Localizable", "DesktopSaveError.missingRepresentedURL.alertTitle")
    }

    public enum NoImageData {
    /// Export Failed
      public static let alertTitle = HighlighterStrings.tr("Localizable", "DesktopSaveError.noImageData.alertTitle")
    }
  }

  public enum DesktopSeekButton {
  /// Hide
    public static let title = HighlighterStrings.tr("Localizable", "DesktopSeekButton.title")
  }

  public enum DesktopSettingsSceneDelegate {
  /// Preferences
    public static let windowTitle = HighlighterStrings.tr("Localizable", "DesktopSettingsSceneDelegate.windowTitle")
  }

  public enum DesktopSettingsView {
  /// Auto-Hidden Words
    public static let wordListLabel = HighlighterStrings.tr("Localizable", "DesktopSettingsView.wordListLabel")
  }

  public enum DismissBarButtonItem {
  /// Done
    public static let title = HighlighterStrings.tr("Localizable", "DismissBarButtonItem.title")
  }

  public enum DocumentScannerNotPurchasedAlertController {
  /// OK
    public static let dismissButton = HighlighterStrings.tr("Localizable", "DocumentScannerNotPurchasedAlertController.dismissButton")
    /// Never Show This
    public static let hideButton = HighlighterStrings.tr("Localizable", "DocumentScannerNotPurchasedAlertController.hideButton")
    /// Learn More…
    public static let learnMoreButton = HighlighterStrings.tr("Localizable", "DocumentScannerNotPurchasedAlertController.learnMoreButton")
    /// Using the document scanner requires the Ultra Highlighter, a one-time purchase.
    public static let message = HighlighterStrings.tr("Localizable", "DocumentScannerNotPurchasedAlertController.message")
    /// Requires Ultra Highlighter
    public static let title = HighlighterStrings.tr("Localizable", "DocumentScannerNotPurchasedAlertController.title")
  }

  public enum DoneButton {
  /// Done
    public static let label = HighlighterStrings.tr("Localizable", "DoneButton.label")
  }

  public enum HighlighterToolBarButtonItem {
  /// Tools
    public static let buttonTitle = HighlighterStrings.tr("Localizable", "HighlighterToolBarButtonItem.buttonTitle")
  }

  public enum IntroView {
  /// Select Photo
    public static let importButtonTitle = HighlighterStrings.tr("Localizable", "IntroView.importButtonTitle")
    /// Or, select a single photo.
    public static let importLabelText = HighlighterStrings.tr("Localizable", "IntroView.importLabelText")
    /// Grant Access
    public static let permissionButtonTitle = HighlighterStrings.tr("Localizable", "IntroView.permissionButtonTitle")
    /// Black Highlighter needs permission to edit your photos.
    public static let permissionLabelText = HighlighterStrings.tr("Localizable", "IntroView.permissionLabelText")
  }

  public enum LimitedLibraryPhotoLibraryViewCell {
  /// Change Selected Photos
    public static let defaultAccessibilityLabel = HighlighterStrings.tr("Localizable", "LimitedLibraryPhotoLibraryViewCell.defaultAccessibilityLabel")
  }

  public enum MenuBuilder {
  /// Find…
    public static let findMenuItemTitle = HighlighterStrings.tr("Localizable", "MenuBuilder.findMenuItemTitle")
  }

  public enum NewFromClipboardCommand {
  /// New from Clipboard
    public static let title = HighlighterStrings.tr("Localizable", "NewFromClipboardCommand.title")
  }

  public enum PageCountAlertFactory {
  /// Highlighter only supports editing one page at a time. Only the first page of your scan will appear.
    public static let alertMessage = HighlighterStrings.tr("Localizable", "PageCountAlertFactory.alertMessage")
    /// Too Many Pages
    public static let alertTitle = HighlighterStrings.tr("Localizable", "PageCountAlertFactory.alertTitle")
    /// OK
    public static let dismissButtonTitle = HighlighterStrings.tr("Localizable", "PageCountAlertFactory.dismissButtonTitle")
  }

  public enum PhotoEditingProtectionAlertController {
  /// Cancel
    public static let cancelButtonTitle = HighlighterStrings.tr("Localizable", "PhotoEditingProtectionAlertController.cancelButtonTitle")
    /// Delete Changes
    public static let deleteButtonTitle = HighlighterStrings.tr("Localizable", "PhotoEditingProtectionAlertController.deleteButtonTitle")
    /// Save to Photos
    public static let saveButtonTitle = HighlighterStrings.tr("Localizable", "PhotoEditingProtectionAlertController.saveButtonTitle")
    /// Share Image
    public static let shareButtonTitle = HighlighterStrings.tr("Localizable", "PhotoEditingProtectionAlertController.shareButtonTitle")
  }

  public enum PhotoEditingViewController {
  /// Redacted Image
    public static let defaultImageName = HighlighterStrings.tr("Localizable", "PhotoEditingViewController.defaultImageName")
  }

  public enum PhotoExportErrorAlertFactory {
  /// OK
    public static let dismissButtonTitle = HighlighterStrings.tr("Localizable", "PhotoExportErrorAlertFactory.dismissButtonTitle")
    /// An error occurred while saving: %@. Please contact support if this continues to happen.
    public static func messageFormat(_ p1: Any) -> String {
      return HighlighterStrings.tr("Localizable", "PhotoExportErrorAlertFactory.messageFormat",String(describing: p1))
    }
    /// Saving Failed
    public static let title = HighlighterStrings.tr("Localizable", "PhotoExportErrorAlertFactory.title")
  }

  public enum PhotoLibraryViewDocumentScannerCell {
  /// Scan Document
    public static let defaultAccessibilityLabel = HighlighterStrings.tr("Localizable", "PhotoLibraryViewDocumentScannerCell.defaultAccessibilityLabel")
  }

  public enum PhotoPermissionsDeniedAlertController {
  /// Open Settings
    public static let actionButtonTitle = HighlighterStrings.tr("Localizable", "PhotoPermissionsDeniedAlertController.actionButtonTitle")
    /// Black Highlighter needs permission to edit your photos. Open Settings to grant access.
    public static let alertMessage = HighlighterStrings.tr("Localizable", "PhotoPermissionsDeniedAlertController.alertMessage")
    /// No Access to Your Photos
    public static let alertTitle = HighlighterStrings.tr("Localizable", "PhotoPermissionsDeniedAlertController.alertTitle")
    /// Dismiss
    public static let cancelButtonTitle = HighlighterStrings.tr("Localizable", "PhotoPermissionsDeniedAlertController.cancelButtonTitle")
  }

  public enum PhotoPermissionsRestrictedAlertController {
  /// Black Highlighter needs permission to edit your photos. However, restrictions on your device prevent that access. Ask whoever controls permissions for you to grant access to the photo library to Black Highlighter.
    public static let alertMessage = HighlighterStrings.tr("Localizable", "PhotoPermissionsRestrictedAlertController.alertMessage")
    /// Photos Access Restricted
    public static let alertTitle = HighlighterStrings.tr("Localizable", "PhotoPermissionsRestrictedAlertController.alertTitle")
    /// Dismiss
    public static let dismissButtonTitle = HighlighterStrings.tr("Localizable", "PhotoPermissionsRestrictedAlertController.dismissButtonTitle")
  }

  public enum PhotoSelectionViewController {
  /// Photos
    public static let navigationItemTitle = HighlighterStrings.tr("Localizable", "PhotoSelectionViewController.navigationItemTitle")
    /// Help
    public static let settingsButtonAccessibilityLabel = HighlighterStrings.tr("Localizable", "PhotoSelectionViewController.settingsButtonAccessibilityLabel")
  }

  public enum PurchaseButton {
  /// Purchase
    public static let purchaseButtonTitleLoading = HighlighterStrings.tr("Localizable", "PurchaseButton.purchaseButtonTitleLoading")
    /// Thank You!
    public static let purchaseButtonTitlePurchased = HighlighterStrings.tr("Localizable", "PurchaseButton.purchaseButtonTitlePurchased")
    /// Purchasing…
    public static let purchaseButtonTitlePurchasing = HighlighterStrings.tr("Localizable", "PurchaseButton.purchaseButtonTitlePurchasing")
    /// Purchase for %@
    public static func purchaseButtonTitleReady(_ p1: Any) -> String {
      return HighlighterStrings.tr("Localizable", "PurchaseButton.purchaseButtonTitleReady",String(describing: p1))
    }
  }

  public enum PurchaseButtonSeparator {
  /// or
    public static let text = HighlighterStrings.tr("Localizable", "PurchaseButtonSeparator.text")
  }

  public enum PurchaseItem {
  /// More Highlighting Power
    public static let subtitleWithoutProduct = HighlighterStrings.tr("Localizable", "PurchaseItem.subtitleWithoutProduct")
    /// Ultimate Highlight Power — %@
    public static func subtitleWithProduct(_ p1: Any) -> String {
      return HighlighterStrings.tr("Localizable", "PurchaseItem.subtitleWithProduct",String(describing: p1))
    }
    /// Ultra Highlighter
    public static let title = HighlighterStrings.tr("Localizable", "PurchaseItem.title")
  }

  public enum PurchaseMarketingTopBarHeadlineLabel {
  /// Ultra Highlighter
    public static let text = HighlighterStrings.tr("Localizable", "PurchaseMarketingTopBarHeadlineLabel.text")
  }

  public enum PurchaseMarketingTopBarSubheadlineLabel {
  /// Unlock these powerful new abilities for Black Highlighter.
    public static let text = HighlighterStrings.tr("Localizable", "PurchaseMarketingTopBarSubheadlineLabel.text")
  }

  public enum PurchaseMarketingView {
  /// Seek and destroy.
    public static let autoRedactionsHeader = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.autoRedactionsHeader")
    /// Choose things you never want to see, and Black Highlighter will find them for you.
    public static let autoRedactionsText = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.autoRedactionsText")
    /// Always ready when you are.
    public static let crossPlatformHeader = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.crossPlatformHeader")
    /// Black Highlighter is right at home on iOS, iPadOS, and macOS.
    public static let crossPlatformText = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.crossPlatformText")
    /// Not digital? Not a problem.
    public static let documentScanningHeader = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.documentScanningHeader")
    /// Scan documents with your phone’s camera and redact them with Black Highlighter.
    public static let documentScanningText = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.documentScanningText")
    /// Plays well with others.
    public static let shortcutsHeader = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.shortcutsHeader")
    /// Build workflows in Shortcuts to combine Black Highlighter with other apps.
    public static let shortcutsText = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.shortcutsText")
    /// Help keep the (high)lights on.
    public static let supportDevelopmentHeader = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.supportDevelopmentHeader")
    /// Your support helps keep updates to Black Highlighter coming!
    public static let supportDevelopmentText = HighlighterStrings.tr("Localizable", "PurchaseMarketingView.supportDevelopmentText")
  }

  public enum PurchaseMarketingViewController {
  /// Ultra Highlighter
    public static let navigationTitle = HighlighterStrings.tr("Localizable", "PurchaseMarketingViewController.navigationTitle")
    /// Restore
    public static let restoreButtonTitle = HighlighterStrings.tr("Localizable", "PurchaseMarketingViewController.restoreButtonTitle")
  }

  public enum RecentsMenuDataSource {
  /// Clear Menu
    public static let clearMenuItemTitle = HighlighterStrings.tr("Localizable", "RecentsMenuDataSource.clearMenuItemTitle")
    /// Open Recent
    public static let menuTitle = HighlighterStrings.tr("Localizable", "RecentsMenuDataSource.menuTitle")
  }

  public enum RedactedWordObservationRotor {
  /// Redacted Words
    public static let name = HighlighterStrings.tr("Localizable", "RedactedWordObservationRotor.name")
  }

  public enum SettingsContentGenerator {
  /// Version %@
    public static func versionStringFormat(_ p1: Any) -> String {
      return HighlighterStrings.tr("Localizable", "SettingsContentGenerator.versionStringFormat",String(describing: p1))
    }
  }

  public enum SettingsContentProvider {

    public enum Item {
    /// About Black Highlighter
      public static let about = HighlighterStrings.tr("Localizable", "SettingsContentProvider.Item.about")
      /// Acknowledgements
      public static let acknowledgements = HighlighterStrings.tr("Localizable", "SettingsContentProvider.Item.acknowledgements")
      /// Auto-Hidden Words
      public static let autoRedactions = HighlighterStrings.tr("Localizable", "SettingsContentProvider.Item.autoRedactions")
      /// Contact the Developer
      public static let contact = HighlighterStrings.tr("Localizable", "SettingsContentProvider.Item.contact")
      /// What’s New
      public static let new = HighlighterStrings.tr("Localizable", "SettingsContentProvider.Item.new")
      /// Privacy Policy
      public static let privacy = HighlighterStrings.tr("Localizable", "SettingsContentProvider.Item.privacy")
    }

    public enum Section {

      public enum OtherApps {
      /// Other Apps by Cocoatype
        public static let header = HighlighterStrings.tr("Localizable", "SettingsContentProvider.Section.otherApps.header")
      }

      public enum PurchasedFeatures {
      /// Ultra Highlighter Features
        public static let header = HighlighterStrings.tr("Localizable", "SettingsContentProvider.Section.purchasedFeatures.header")
      }

      public enum WebURLs {
      /// Important Information
        public static let header = HighlighterStrings.tr("Localizable", "SettingsContentProvider.Section.webURLs.header")
      }
    }
  }

  public enum SettingsView {
  /// Automatically hiding words requires the Ultra Highlighter, a one-time purchase.
    public static let notPurchasedAlertMessage = HighlighterStrings.tr("Localizable", "SettingsView.notPurchasedAlertMessage")
    /// Requires Ultra Highlighter
    public static let notPurchasedAlertTitle = HighlighterStrings.tr("Localizable", "SettingsView.notPurchasedAlertTitle")
    /// OK
    public static let notPurchasedDismissButton = HighlighterStrings.tr("Localizable", "SettingsView.notPurchasedDismissButton")
    /// Never Show This
    public static let notPurchasedHideButton = HighlighterStrings.tr("Localizable", "SettingsView.notPurchasedHideButton")
  }

  public enum SettingsViewController {
  /// Settings
    public static let navigationTitle = HighlighterStrings.tr("Localizable", "SettingsViewController.navigationTitle")
  }

  public enum ShareItem {
  /// Share
    public static let label = HighlighterStrings.tr("Localizable", "ShareItem.label")
  }

  public enum ToolPickerItem {
  /// Eraser
    public static let eraserToolItem = HighlighterStrings.tr("Localizable", "ToolPickerItem.eraserToolItem")
    /// Tools
    public static let itemLabel = HighlighterStrings.tr("Localizable", "ToolPickerItem.itemLabel")
    /// Magic Highlighter
    public static let magicToolItem = HighlighterStrings.tr("Localizable", "ToolPickerItem.magicToolItem")
    /// Manual Highlighter
    public static let manualToolItem = HighlighterStrings.tr("Localizable", "ToolPickerItem.manualToolItem")
    /// Tools
    public static let menuTitle = HighlighterStrings.tr("Localizable", "ToolPickerItem.menuTitle")
  }

  public enum WordObservationAccessibilityElement {
  /// Redacted
    public static let redactedValue = HighlighterStrings.tr("Localizable", "WordObservationAccessibilityElement.redactedValue")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension HighlighterStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
