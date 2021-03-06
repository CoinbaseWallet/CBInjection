// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import UIKit

public extension UINavigationController {
    /// Initialize the navigation controller with an injected root view controller
    ///
    /// - Parameter rootViewControllerKey: the injection key for the root view controller
    convenience init(rootViewControllerKey: ViewControllerInjectionKey) {
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
    ///
    /// - Returns: Instance of ViewController generated using provided injection key
    @discardableResult
    func pushViewController(_ key: ViewControllerInjectionKey, animated: Bool) -> UIViewController? {
        guard let viewController = try? Dependencies.shared.provide(key) else {
            assertionFailure("Unable to push view controller for key \(key)")
            return nil
        }

        pushViewController(viewController, animated: animated)

        return viewController
    }

    /// Set the navigation controller's view controllers from their injection keys
    ///
    /// - Parameters:
    ///   - keys: Injection keys for the view controllers
    ///   - animated: true if the transition should be animated
    func setViewControllers(_ keys: [ViewControllerInjectionKey], animated: Bool) {
        let viewControllers = keys.compactMap { key -> UIViewController? in
            guard let viewController: UIViewController = try? Dependencies.shared.provide(key) else {
                assertionFailure("Unable to push view controller for key \(key)")
                return nil
            }

            return viewController
        }

        setViewControllers(viewControllers, animated: animated)
    }

    /// Set the navigation controllers root view controller using provided injection key
    ///
    /// - Parameters:
    ///   - key: Injection key for the view controller
    ///   - animated: true if the transition should be animated
    ///
    /// - Returns: Instance of ViewController generated using provided injection key
    func setRootViewController(_ key: ViewControllerInjectionKey, animated: Bool) -> UIViewController? {
        guard let viewController = try? Dependencies.shared.provide(key) else {
            assertionFailure("Unable to push view controller for key \(key)")
            return nil
        }

        setViewControllers([viewController], animated: animated)

        return viewController
    }
}
