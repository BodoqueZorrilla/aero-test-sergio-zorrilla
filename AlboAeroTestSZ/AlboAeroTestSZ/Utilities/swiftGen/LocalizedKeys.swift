// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum LocalizedKeys {

  internal enum Search {
    /// SEARCH
    internal static let button = LocalizedKeys.tr("Localizable", "search.button")
    /// RADIUS IN KM
    internal static let radius = LocalizedKeys.tr("Localizable", "search.radius")
    /// AIRPORT\nfinder
    internal static let title = LocalizedKeys.tr("Localizable", "search.title")
    internal enum Alert {
      /// Cancel
      internal static let cancel = LocalizedKeys.tr("Localizable", "search.alert.cancel")
      /// Please go to Settings and turn on the permissions of location
      internal static let message = LocalizedKeys.tr("Localizable", "search.alert.message")
      /// Settings
      internal static let settings = LocalizedKeys.tr("Localizable", "search.alert.settings")
      /// Alert
      internal static let title = LocalizedKeys.tr("Localizable", "search.alert.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension LocalizedKeys {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
