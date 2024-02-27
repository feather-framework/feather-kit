//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/02/2024.
//

public struct ID<T>:
    Codable,
    Equatable,
    Hashable,
    RawRepresentable,
    CustomStringConvertible
{
    public var description: String {
        rawValue
    }

    public let rawValue: String

    public init(_ value: String) {
        self.rawValue = value
    }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
