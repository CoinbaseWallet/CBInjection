// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import Foundation

/// Simple dependency injection framework. Note: This doesn't resolve circular reference dependencies.
public final class Dependencies {
    public static let shared = Dependencies()

    /// Makes sure singleton access is thread safe
    private let singletonLock = NSRecursiveLock()

    /// Holds on to cached singletons
    private var cache = [InjectionKeys: Any]()

    /// Get injection for given injection key
    ///
    /// - Parameters:
    ///     - key: Key specifying type of injection
    ///
    /// - Returns: Instance of the requested dependency or an error is thrown
    public func provide<T>(_ key: InjectionKey<T>) throws -> T {
        switch key.scope {
        case .singleton:
            singletonLock.lock()
            defer { singletonLock.unlock() }

            if let instance = cache[key] as? T {
                return instance
            }

            if let instance = try self.resolve(key) {
                cache[key] = instance
                return instance
            }
        case .transient:
            if let instance = try self.resolve(key) {
                return instance
            }
        }

        throw DependenciesError.unableToResolveDependency(key)
    }

    /// Destroy all dependencies
    public func destroy() {
        cache.removeAll()
    }

    // MARK: helpers

    func resolve<T>(_ key: InjectionKey<T>) throws -> T? {
        if let closure = key.closure {
            return try closure(self)
        } else if let instance = try key.injection?.provide(using: self, parameters: key.parameters) {
            return instance
        }

        throw DependenciesError.unableToResolveDependency(key)
    }
}
