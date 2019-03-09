// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

/// Conformers of this protocol can resolve a dependency
public protocol DependencyInjection {
    /// Default constructor
    init()

    /// Resolve dependency
    ///
    /// - Parameters:
    ///     - dependencies: provider for resolving other dependencies
    ///
    /// - Returns: Instance of the requested dependency or an error is thrown
    func provide(using dependencies: Dependencies, parameters: [InjectionParameterName: Any]) throws -> Any
}
