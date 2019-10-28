// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import UIKit

public extension UIViewController {
    /// Modally present view controller generated from given injection key
    ///
    /// - Parameters:
    ///     - key: Key used to create view controller
    ///     - animated: Animate present transition
    ///     - modalPresentationStyle: Customize modal presentation
    ///     - completion: Completion block called when transition completes
    ///
    /// - Returns: Instance of ViewController generated using provided injection key
    @discardableResult
    func present(
        _ key: ViewControllerInjectionKey,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) -> UIViewController? {
        guard let viewController = try? Dependencies.shared.provide(key) else {
            assertionFailure("Unable to present view controller for key \(key)")
            return nil
        }

        viewController.modalPresentationStyle = key.modalPresentationStyle

        present(viewController, animated: animated, completion: completion)

        return viewController
    }

    /// Add child view controller using provided injection key
    ///
    /// - Parameters:
    ///     - key: Key used to create view controller
    ///
    /// - Returns: Instance of ViewController generated using provided injection key
    func addChild(_ key: ViewControllerInjectionKey) -> UIViewController? {
        guard let viewController = try? Dependencies.shared.provide(key) else {
            assertionFailure("Unable to present view controller for key \(key)")
            return nil
        }

        viewController.willMove(toParent: self)
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        return viewController
    }
}
