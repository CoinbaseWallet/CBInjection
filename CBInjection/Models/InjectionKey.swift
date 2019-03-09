// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

import Foundation

/// Closure used to resolve dependency
public typealias InjectionKeyClosure = ((Dependencies) throws -> Any)

/// Represents and injection key used indentify a dependency.
public final class InjectionKey<T>: InjectionKeys {
    /// Injection which contains the code for resolving a dependency
    let injection: DependencyInjection?

    /// Kind of injection. Singleton vs transient
    let kind: InjectionKind

    /// List of parameters to pass to injection conformer
    let parameters: [InjectionParameterName: Any]

    /// Closure which contains the code for resoliving dependency. A closure or injection can be used
    /// to resolve a dependency but not both
    let closure: InjectionKeyClosure?

    /// Injection-based constructor
    public required init(
        uuid: String = NSUUID().uuidString,
        using injectionObjectType: DependencyInjection.Type,
        kind: InjectionKind,
        parameters: [InjectionParameterName: Any] = [:]
    ) {
        injection = injectionObjectType.init()
        self.kind = kind
        self.parameters = parameters
        closure = nil
        super.init(uuid: uuid)
    }

    /// Closure-based constructor
    public init(
        uuid: String = NSUUID().uuidString,
        kind: InjectionKind,
        parameters: [InjectionParameterName: Any] = [:],
        closure: @escaping InjectionKeyClosure
    ) {
        self.kind = kind
        self.parameters = parameters
        self.closure = closure
        injection = nil
        super.init(uuid: uuid)
    }

    @available(*, unavailable)
    required init(uuid _: String) {
        fatalError("init(uuid:) has not been implemented")
    }
}

/// Static injection keys should be added to this class
public class InjectionKeys: Hashable {
    /// Unique ID used to identify and cache singletons
    let uuid: String

    required init(uuid _: String) {
        uuid = NSUUID().uuidString
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    public static func == (lhs: InjectionKeys, rhs: InjectionKeys) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
