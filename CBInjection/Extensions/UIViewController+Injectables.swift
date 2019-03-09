// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import UIKit

public extension UIViewController {
    /// Modally present view controller generated from given injection key
    ///
    /// - Parameters:
    ///     - key: Key used to create view controller
    ///     - animated: Animate present transition
    ///     - completion: Completion block called when transition completes
    @discardableResult
    public func present<T: UIViewController>(
        _ key: InjectionKey<T>,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) -> T? {
        guard let viewController = try? Dependencies.shared.provide(key) else {
            assertionFailure("Unable to present view controller for key \(key)")
            return nil
        }

        present(viewController, animated: animated, completion: completion)

        return viewController
    }
}
