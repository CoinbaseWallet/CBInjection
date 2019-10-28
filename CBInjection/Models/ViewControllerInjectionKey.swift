// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import UIKit

public class ViewControllerInjectionKey: InjectionKey<UIViewController> {
    /// View controller modal presentation style
    let modalPresentationStyle: UIModalPresentationStyle

    public required init(
        uuid: String = NSUUID().uuidString,
        scope: InjectionScope,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        closure: @escaping (Dependencies) throws -> UIViewController
    ) {
        self.modalPresentationStyle = modalPresentationStyle
        super.init(uuid: uuid, scope: scope, closure: closure)
    }

    public required init(
        uuid: String = NSUUID().uuidString,
        using injectionObjectType: DependencyInjection<UIViewController>.Type,
        scope: InjectionScope,
        parameters: [InjectionParameterName: Any] = [:],
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen
    ) {
        self.modalPresentationStyle = modalPresentationStyle
        super.init(uuid: uuid, using: injectionObjectType, scope: scope, parameters: parameters)
    }

    @available(*, unavailable)
    public required init(
        uuid: String = NSUUID().uuidString,
        scope: InjectionScope,
        closure: @escaping ((Dependencies) throws -> UIViewController)
    ) {
        fatalError("init(uuid:scope:closure:) has not been implemented")
    }

    @available(*, unavailable)
    public required init(
        uuid: String = NSUUID().uuidString,
        using injectionObjectType: DependencyInjection<UIViewController>.Type,
        scope: InjectionScope,
        parameters: [InjectionParameterName : Any] = [:]
    ) {
        fatalError("init(uuid:using:scope:parameters:) has not been implemented")
    }
}
