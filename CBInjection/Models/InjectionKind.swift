// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import Foundation

/// Represents kind of injection
public enum InjectionKind {
    /// This means a new instance is created every time the dependency is resolved
    case transient

    /// This returns a single instance every time the dependency is resolved
    case singleton
}
