//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 27/02/2024.
//


// NOTE: we should improve this...
public struct ForbiddenState {

    public enum Kind {
        case permission
        case role
        case access
    }

    public let key: String
    public let kind: Kind

    public init(key: String, kind: Kind) {
        self.key = key
        self.kind = kind
    }
}

public enum UnauthorizedState {
    case credentials
    case token
    case any
}
