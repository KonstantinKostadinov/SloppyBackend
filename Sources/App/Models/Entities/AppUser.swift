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

    @Field(key: "email")
    var email: String
    
    @Field(key: "passwordHash")
    var passwordHash: String

    @Field(key: "plantIds")
    var plantIds: [UUID]

    @Field(key: "sharedPlantIds")
    var sharedPlantIds: [UUID]
    
    var response: AppUserResponse {
        .init(email: email, userID: id!)
    }

    var fullResponse: AppUserFullResponse {
        .init(email: email, userID: id!, plaintIds: plantIds, sharedPlantIds: sharedPlantIds)
    }

    var ownedAndSharedPlantsReponse: AppOwndAndSharedPlantsResponse {
        .init(plantIds: plantIds, sharedPlantIds: sharedPlantIds)
    }
    
    init() {}
    
    init(id: UUID? = nil, email: String, passwordHash: String, plantIds: [UUID] = [UUID](), sharedPlantIds: [UUID] = [UUID]()){
        self.id = id
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

