// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum ActionStrings {
  public enum InfoPlist {
  /// Hide Text
    public static let cfBundleDisplayName = ActionStrings.tr("InfoPlist", "CFBundleDisplayName")
  }
  public enum Localizable {

    public enum ActionEditingDismissalAlertController {
    /// Cancel
      public static let cancelButtonTitle = ActionStrings.tr("Localizable", "ActionEditingDismissalAlertController.cancelButtonTitle")
      /// Delete Changes
      public static let deleteButtonTitle = ActionStrings.tr("Localizable", "ActionEditingDismissalAlertController.deleteButtonTitle")
      /// Save to Photos
      public static let saveButtonTitle = ActionStrings.tr("Localizable", "ActionEditingDismissalAlertController.saveButtonTitle")
    }

    public enum BasePhotoEditingViewController {
    /// Redo Redaction
      public static let redoKeyCommandDiscoverabilityTitle = ActionStrings.tr("Localizable", "BasePhotoEditingViewController.redoKeyCommandDiscoverabilityTitle")
      /// Undo Redaction
      public static let undoKeyCommandDiscoverabilityTitle = ActionStrings.tr("Localizable", "BasePhotoEditingViewController.undoKeyCommandDiscoverabilityTitle")
    }

    public enum ToolPickerItem {
    /// Eraser
      public static let eraserToolItem = ActionStrings.tr("Localizable", "ToolPickerItem.eraserToolItem")
      /// Magic Highlighter
      public static let magicToolItem = ActionStrings.tr("Localizable", "ToolPickerItem.magicToolItem")
      /// Manual Highlighter
      public static let manualToolItem = ActionStrings.tr("Localizable", "ToolPickerItem.manualToolItem")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension ActionStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
