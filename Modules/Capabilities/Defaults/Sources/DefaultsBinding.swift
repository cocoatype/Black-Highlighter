//  Created by Geoff Pado on 6/17/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation
import SwiftUI

extension Defaults {
    @propertyWrapper public struct Binding<ValueType> {
        public var wrappedValue: ValueType {
            get {
                Self.object(for: key, fallback: fallback)
            }
            nonmutating set {
                Self.userDefaults.set(newValue, forKey: key.rawValue)
                NotificationCenter.default.post(name: valueDidChange, object: nil)
            }
        }

        public init(key: Defaults.Key, fallback: ValueType) {
            self.key = key
            self.fallback = fallback
            let valueDidChange = Notification.Name("Defaults.valueDidChange.\(key.rawValue)")
            self.binding = SwiftUI.Binding(get: {
                Self.object(for: key, fallback: fallback)
            }, set: {
                Self.userDefaults.set($0, forKey: key.rawValue)
                NotificationCenter.default.post(name: valueDidChange, object: nil)
            })
            self.valueDidChange = valueDidChange
        }

        public init(key: Defaults.Key) where ValueType == Bool {
            self.init(key: key, fallback: false)
        }

        public init(key: Defaults.Key) where ValueType == Int {
            self.init(key: key, fallback: 0)
        }

        public init<ElementType>(key: Defaults.Key) where ValueType == [ElementType] {
            self.init(key: key, fallback: [])
        }

        public init<DictKey, DictValue>(key: Defaults.Key) where ValueType == [DictKey: DictValue] {
            self.init(key: key, fallback: [:])
        }

        private let key: Defaults.Key
        private let fallback: ValueType

        // MARK: Projected Value

        public var projectedValue: SwiftUI.Binding<ValueType> {
            return binding
        }

        private let binding: SwiftUI.Binding<ValueType>//CurrentValueSubject<ValueType, Never>

        // MARK: Boilerplate

        private static func object(for key: Key, fallback: ValueType) -> ValueType {
            guard let object = Self.userDefaults.object(forKey: key.rawValue) as? ValueType else { return fallback }
            return object
        }

        public let valueDidChange: Notification.Name

        static var userDefaults: UserDefaults {
            guard ProcessInfo.processInfo.environment["IS_TEST"] == nil else {
                return UserDefaults.test
            }

            return UserDefaults.standard
        }
    }
}
