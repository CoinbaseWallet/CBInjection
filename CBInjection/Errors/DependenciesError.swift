// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import Foundation

/// Dependencies-related Error
public enum DependenciesError: Error {
    /// Error thrown when unable to resolve dependency
    case unableToResolveDependency(InjectionKeys)

    /// Error thrown when injection doesn't supply the correct list of parameters
    case missingParameters
}
