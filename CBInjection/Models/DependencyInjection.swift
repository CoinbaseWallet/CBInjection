// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

/// Conformers of this protocol can resolve a dependency
open class DependencyInjection<T> {
    /// Default constructor
    public required init() {}

    /// Resolve dependency
    ///
    /// - Parameters:
    ///     - dependencies: provider for resolving other dependencies
    ///
    /// - Returns: Instance of the requested dependency or an error is thrown
    open func provide(using _: Dependencies, parameters _: [InjectionParameterName: Any]) throws -> T {
        throw DependenciesError.injectionNotImplemented
    }
}
