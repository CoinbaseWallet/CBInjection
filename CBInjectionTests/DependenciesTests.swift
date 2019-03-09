// Copyright (c) 2017-2019 Coinbase Inc. See LICENSE

@testable import CBInjection
import XCTest

private let expectedName = "Notorious B.I.G."
private let expecetdID = 123

class DependenciesTests: XCTestCase {
    func testSingleton() throws {
        let actual = try Dependencies.shared.provide(.dummySingleton)
        let actual2 = try Dependencies.shared.provide(.dummySingleton)

        XCTAssertEqual(expecetdID, actual.id)
        XCTAssertEqual(expectedName, actual.name)

        XCTAssertEqual(expecetdID, actual2.id)
        XCTAssertEqual(expectedName, actual2.name)

        XCTAssertEqual(actual.date, actual2.date)
    }

    func testTransient() throws {
        let actual = try Dependencies.shared.provide(.dummyTransient)
        let actual2 = try Dependencies.shared.provide(.dummyTransient)

        XCTAssertEqual(expecetdID, actual.id)
        XCTAssertEqual(expectedName, actual.name)

        XCTAssertEqual(expecetdID, actual2.id)
        XCTAssertEqual(expectedName, actual2.name)

        XCTAssertNotEqual(actual.date, actual2.date)
    }

    func testInjectedTransient() throws {
        let actual = try Dependencies.shared.provide(.dummyInjectedTransient)
        let actual2 = try Dependencies.shared.provide(.dummyInjectedTransient)

        XCTAssertEqual(expecetdID, actual.id)
        XCTAssertEqual(expectedName, actual.name)
        XCTAssertEqual(expecetdID, actual.transientDep.id)
        XCTAssertEqual(expectedName, actual.transientDep.name)

        XCTAssertEqual(expecetdID, actual2.id)
        XCTAssertEqual(expectedName, actual2.name)
        XCTAssertEqual(expecetdID, actual2.transientDep.id)
        XCTAssertEqual(expectedName, actual2.transientDep.name)

        XCTAssertNotEqual(actual.date, actual2.date)
    }

    func testInjectedTransientInSingleton() throws {
        let actual = try Dependencies.shared.provide(.dummyInjectedTransientInSingleton)
        let actual2 = try Dependencies.shared.provide(.dummyInjectedTransientInSingleton)

        XCTAssertEqual(expecetdID, actual.id)
        XCTAssertEqual(expectedName, actual.name)
        XCTAssertEqual(expecetdID, actual.transientDep.id)
        XCTAssertEqual(expectedName, actual.transientDep.name)

        XCTAssertEqual(expecetdID, actual2.id)
        XCTAssertEqual(expectedName, actual2.name)
        XCTAssertEqual(expecetdID, actual2.transientDep.id)
        XCTAssertEqual(expectedName, actual2.transientDep.name)

        XCTAssertEqual(actual.date, actual2.date)
        XCTAssertEqual(actual.transientDep.date, actual2.transientDep.date)
        XCTAssertEqual(actual.transientDep.id, actual2.transientDep.id)
        XCTAssertEqual(actual.transientDep.name, actual2.transientDep.name)
    }

    func testInjectedClosureTransientInSingleton() throws {
        let actual = try Dependencies.shared.provide(.closureStyleSingletontKey)
        let actual2 = try Dependencies.shared.provide(.closureStyleSingletontKey)

        XCTAssertEqual(expecetdID, actual.id)
        XCTAssertEqual(expectedName, actual.name)
        XCTAssertEqual(expecetdID, actual.transientDep.id)
        XCTAssertEqual(expectedName, actual.transientDep.name)

        XCTAssertEqual(expecetdID, actual2.id)
        XCTAssertEqual(expectedName, actual2.name)
        XCTAssertEqual(expecetdID, actual2.transientDep.id)
        XCTAssertEqual(expectedName, actual2.transientDep.name)

        XCTAssertEqual(actual.date, actual2.date)
        XCTAssertEqual(actual.transientDep.date, actual2.transientDep.date)
        XCTAssertEqual(actual.transientDep.id, actual2.transientDep.id)
        XCTAssertEqual(actual.transientDep.name, actual2.transientDep.name)
    }

    func testInjectedClosureTransient() throws {
        let actual = try Dependencies.shared.provide(.closureStyleTransientKey)
        let actual2 = try Dependencies.shared.provide(.closureStyleTransientKey)

        XCTAssertEqual(expecetdID, actual.id)
        XCTAssertEqual(expectedName, actual.name)
        XCTAssertEqual(expecetdID, actual.transientDep.id)
        XCTAssertEqual(expectedName, actual.transientDep.name)

        XCTAssertEqual(expecetdID, actual2.id)
        XCTAssertEqual(expectedName, actual2.name)
        XCTAssertEqual(expecetdID, actual2.transientDep.id)
        XCTAssertEqual(expectedName, actual2.transientDep.name)

        XCTAssertNotEqual(actual.date, actual2.date)
    }
}

private extension InjectionKeys {
    static let dummySingleton = InjectionKey<DummyDependency>(
        using: DummyDependencyInjection.self,
        kind: .singleton
    )

    static let dummyTransient = InjectionKey<DummyDependency>(
        using: DummyDependencyInjection.self,
        kind: .transient
    )

    static let dummyInjectedTransient = InjectionKey<DummyInjectedTransient>(
        using: DummyInjectedTransientInjection.self,
        kind: .transient
    )

    static let dummyInjectedTransientInSingleton = InjectionKey<DummyInjectedTransient>(
        using: DummyInjectedTransientInjection.self,
        kind: .singleton
    )

    static let closureStyleTransientKey = InjectionKey<DummyInjectedTransient>(kind: .transient) { dependencies in
        let dep = try dependencies.provide(.dummyTransient)
        return DummyInjectedTransient(id: expecetdID, name: expectedName, date: Date(), transientDep: dep)
    }

    static let closureStyleSingletontKey = InjectionKey<DummyInjectedTransient>(kind: .singleton) { dependencies in
        let dep = try dependencies.provide(.dummyTransient)
        return DummyInjectedTransient(id: expecetdID, name: expectedName, date: Date(), transientDep: dep)
    }
}

struct DummyInjectedTransient {
    let id: Int
    let name: String
    let date: Date
    let transientDep: DummyDependency
}

struct DummyDependency {
    let id: Int
    let name: String
    let date: Date
}

final class DummyDependencyInjection: DependencyInjection {
    func provide(using _: Dependencies, parameters: [InjectionParameterName: Any]) throws -> Any {
        return DummyDependency(id: expecetdID, name: expectedName, date: Date())
    }
}

final class DummyInjectedTransientInjection: DependencyInjection {
    func provide(using dependencies: Dependencies, parameters _: [InjectionParameterName: Any]) throws -> Any {
        let dep = try dependencies.provide(.dummyTransient)
        return DummyInjectedTransient(id: expecetdID, name: expectedName, date: Date(), transientDep: dep)
    }
}
