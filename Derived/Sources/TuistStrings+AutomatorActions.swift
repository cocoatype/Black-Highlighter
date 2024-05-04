// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum AutomatorActionsStrings {
  /// Image files.
  public static let amdInput = AutomatorActionsStrings.tr("InfoPlist", "AMDInput")
  /// Image files.
  public static let amdResult = AutomatorActionsStrings.tr("InfoPlist", "AMDResult")
  /// Redact occurrences of a specified word in the input images.
  public static let amdSummary = AutomatorActionsStrings.tr("InfoPlist", "AMDSummary")
  /// https://blackhighlighter.app/
  public static let amdWebsite = AutomatorActionsStrings.tr("InfoPlist", "AMDWebsite")
  /// Redact Images
  public static let amName = AutomatorActionsStrings.tr("InfoPlist", "AMName")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension AutomatorActionsStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
