//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//


public protocol FeatherInterface: Sendable {

    @discardableResult
    func auth<T>(
        _ user: ACLInterface,
        _ block: (() async throws -> T)
    ) async throws -> T
}

extension FeatherInterface {

    @discardableResult
    public func auth<T>(
        _ user: ACLInterface,
        _ block: (() async throws -> T)
    ) async throws -> T {
        try await ACL.authenticate(user, block)
    }
}

