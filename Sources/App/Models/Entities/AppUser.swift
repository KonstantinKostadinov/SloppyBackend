//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor
import Foundation
import Fluent
import JWT

final class AppUser: Model, Content {
    static let schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "firstName")
    var firstName: String
    
    @Field(key: "lastName")
    var lastName: String
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "passwordHash")
    var passwordHash: String

    
    var response: AppUserResponse {
        .init(username: username, firstName: firstName, lastName: lastName, userID: id!)
    }
    
    init() {}
    
    init(id: UUID? = nil, firstName: String, lastName: String,username: String, passwordHash: String){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.passwordHash = passwordHash
    }
}

extension AppUser: ModelAuthenticatable {
    static let usernameKey = \AppUser.$username
    static let passwordHashKey = \AppUser.$passwordHash
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}

extension AppUser: JWTPayload {
    func verify(using signer: JWTSigner) throws {
    }
}

