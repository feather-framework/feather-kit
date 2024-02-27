//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 27/02/2024.
//


public enum ACLError: Error {
    case unauthorized(UnauthorizedState)
    case forbidden(ForbiddenState)
}
