// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import UIKit

public extension UINavigationController {
    /// Initialize the navigation controller with an injected root view controller
    ///
    /// - Parameter rootViewControllerKey: the injection key for the root view controller
    public convenience init(rootViewControllerKey: InjectionKey<UIViewController>) {
        guard let viewController = try? Dependencies.shared.provide(rootViewControllerKey) else {
            fatalError("View controller not found")
        }

        self.init(rootViewController: viewController)
    }

    /// Push view controller generated from given injection key
    ///
    /// - Parameters:
    ///     - key: Key used to create view controller
    ///     - animated: Animate push transition
    public func pushViewController<T: UIViewController>(_ key: InjectionKey<T>, animated: Bool) {
        guard let viewController = try? Dependencies.shared.provide(key) else {
            return assertionFailure("Unable to push view controller for key \(key)")
        }

        pushViewController(viewController, animated: animated)
    }

    /// Set the navigation controller's view controllers from their injection keys
    ///
    /// - Parameters:
    ///   - keys: Injection keys for the view controllers
    ///   - animated: true if the transition should be animated
    public func setViewControllers<T: UIViewController>(_ keys: [InjectionKey<T>], animated: Bool) {
        let viewControllers = keys.compactMap { key -> UIViewController? in
            guard let viewController: UIViewController = try? Dependencies.shared.provide(key) else {
                assertionFailure("Unable to push view controller for key \(key)")
                return nil
            }

            return viewController
        }

        setViewControllers(viewControllers, animated: animated)
    }
}