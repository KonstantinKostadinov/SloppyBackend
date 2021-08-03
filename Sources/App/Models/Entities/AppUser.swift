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
    var id: String?
    
    @Field(key: "firstName")
    var firstName: String
    
    @Field(key: "lastName")
    var lastName: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "passwordHash")
    var passwordHash: String

    @Field(key: "plantIds")
    var plantIds: [String]

    @Field(key: "sharedPlantIds")
    var sharedPlantIds: [String]
    
    var response: AppUserResponse {
        .init(email: email, firstName: firstName, lastName: lastName, userID: id!)
    }

    var fullResponse: AppUserFullResponse {
        .init(email: email, firstName: firstName, lastName: lastName, userID: id!, plaintIds: plantIds, sharedPlantIds: sharedPlantIds)
    }
    
    init() {}
    
    init(id: String? = nil, firstName: String, lastName: String, email: String, passwordHash: String, plantIds: [String] = [String](), sharedPlantIds: [String] = [String]()){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.passwordHash = passwordHash
        self.plantIds = plantIds
        self.sharedPlantIds = sharedPlantIds
    }
}

extension AppUser: ModelAuthenticatable {
    static let usernameKey = \AppUser.$email
    static let passwordHashKey = \AppUser.$passwordHash
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}

extension AppUser: JWTPayload {
    func verify(using signer: JWTSigner) throws {
    }
}

