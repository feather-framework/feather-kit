//
//  File.swift
//
//
//  Created by Tibor Bodecs on 05/02/2024.
//


public protocol ACLInterface {

    func hasRole(_ key: String) async throws -> Bool
    func hasPermission(_ key: String) async throws -> Bool
    func hasAccess(_ key: String, userInfo: [String: Any]) async throws -> Bool

    func requirePermission(_ key: String) async throws
}

extension ACLInterface {

    public func requireRole(_ key: String) async throws {
        guard try await hasRole(key) else {
            throw ACLError.forbidden(
                .init(
                    key: key,
                    kind: .role
                )
            )
        }
    }

    public func requirePermission(_ key: String) async throws {
        guard try await hasPermission(key) else {
            throw ACLError.forbidden(
                .init(
                    key: key,
                    kind: .permission
                )
            )
        }
    }

    public func requirePermission(_ key: String, userInfo: [String: Any])
        async throws
    {
        guard try await hasAccess(key, userInfo: userInfo) else {
            throw ACLError.forbidden(
                .init(
                    key: key,
                    kind: .access
                )
            )
        }
    }
}

// MARK: -

public enum ACL {

//    struct GuestUser: ACLInterface {
//
//        public func hasRole(
//            _ key: String
//        ) async throws -> Bool { false }
//
//        public func hasPermission(
//            _ key: String
//        ) async throws -> Bool { false }
//
//        public func hasAccess(
//            _ key: String,
//            userInfo: [String: Any]
//        ) async throws -> Bool { false }
//    }

    // MARK: -

    public struct AuthenticatedUser: ACLInterface {

        public let accountId: String
        public let roleKeys: [String]
        public let permissionKeys: [String]

        public init(
            accountId: String,
            roleKeys: [String],
            permissionKeys: [String]
        ) {
            self.accountId = accountId
            self.roleKeys = roleKeys
            self.permissionKeys = permissionKeys
        }

        public func hasRole(
            _ key: String
        ) async throws -> Bool {
            roleKeys.contains(key)
        }

        public func hasPermission(
            _ key: String
        ) async throws -> Bool {
            permissionKeys.contains(key)
        }

        public func hasAccess(
            _ key: String,
            userInfo: [String: Any]
        ) async throws -> Bool {
            false
        }
    }

    // MARK: -

    @TaskLocal
    private static var rawValue: ACLInterface?

    public static func authenticate<R>(
        _ user: ACLInterface,
        _ block: (() async throws -> R)
    ) async throws -> R {
        return try await $rawValue.withValue(user) {
            try await block()
        }
    }

    public static func set<T: ACLInterface, R>(
        value: T?,
        _ block: (() async throws -> R)
    ) async throws -> R {
        try await $rawValue.withValue(value) {
            try await block()
        }
    }

    public static func unset<T: ACLInterface, R>(
        _: T.Type,
        _ block: (() async throws -> R)
    ) async throws -> R {
        try await $rawValue.withValue(nil) {
            try await block()
        }
    }

    public static func get<T: ACLInterface>(
        _: T.Type
    ) async throws -> T? {
        rawValue as? T
    }

    public static func require<T: ACLInterface>(
        _: T.Type
    ) async throws -> T {
        guard let value = rawValue as? T else {
            throw ACLError.unauthorized(.any)
        }
        return value
    }

    public static func exists<T: ACLInterface>(
        _: T.Type
    ) async throws -> Bool {
        rawValue as? T != nil
    }
}
