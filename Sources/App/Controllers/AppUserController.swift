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

struct AppUserController {
    struct Unprotected {}
    struct PasswordProtected {}
    struct TokenProtected {}
}

extension AppUserController.Unprotected: RouteCollection {
    func register(req: Request) throws -> EventLoopFuture<Response> {
        try AppUserRequest.validate(content: req)
        let create = try req.content.decode(AppUserRequest.self)

        guard  create.password == create.confirmPassword else { throw Abort(.badRequest, reason: "Passwords didn't match") }

        let user = try AppUser(email: create.email, passwordHash: Bcrypt.hash(create.password, cost: 10))
        let token = try req.jwt.sign(user)

        return user.save(on: req.db).flatMap {
            let loginResponse = AppUserRegisterResponse(user: user.response, accessToken: token)
            return DataWrapper.encodeResponse(data: loginResponse, for: req)
        }
    }

    func boot(routes: RoutesBuilder) throws {
        routes.post(Endpoint.API.Users.register, use: register)
    }
}

extension AppUserController.PasswordProtected: RouteCollection {
    func login(req: Request) throws -> EventLoopFuture<Response> {
        try AppUserLoginRequest.validate(content: req)
        let loginCredentials = try req.content.decode(AppUserLoginRequest.self)
        return  AppUser.query(on: req.db).filter(\.$email == loginCredentials.email).first().flatMap { (appUser) in
            do {
            if let user = appUser {
                // user was identified by email
                if try! user.verify(password: loginCredentials.password) {
                    // password matches what is stored
                    let token = try req.jwt.sign(user)
                    let loginResponse = AppUserLoginResponse(user: user.fullResponse, accessToken: token)
                    return DataWrapper.encodeResponse(data: loginResponse, for: req)
                    // login has succeeded
                } else {
                    let failStruct = Fail(message: "wrong pass")
                    return DataWrapper.encodeResponse(data: failStruct, for: req)
                }
            } else {
                let failStruct = Fail(message: "ne rapnato")
                return DataWrapper.encodeResponse(data: failStruct, for: req)
            }
            } catch {
                let failStruct = Fail(message: error.localizedDescription)
                return DataWrapper.encodeResponse(data: failStruct, for: req)
            }
            let failStruct = Fail(message: "krai do ")
            return DataWrapper.encodeResponse(data: failStruct, for: req)
        }
        let failStruct = Fail(message: "posleno")
        return DataWrapper.encodeResponse(data: failStruct, for: req)
        

//        guard let appUser = user else { throw Abort(.badRequest, reason: "user is nil")}
//        if try Bcrypt.verify(loginCredentials.password, created: appUser.passwordHash) {
//            let token = try req.jwt.sign(appUser)
//            let loginResponse = AppUserLoginResponse(user: appUser.response, accessToken: token)
//            return DataWrapper.encodeResponse(data: loginResponse, for: req)
//        } else {
//            throw Abort(.badRequest, reason: "passwords dont match")
//        }
        
//        let user = try req.auth.require(AppUser.self)
//        let token = try req.jwt.sign(user)
//        let loginResponse = AppUserLoginResponse(user: user.response, accessToken: token)
//        return DataWrapper.encodeResponse(data: loginResponse, for: req)
    }
    func boot(routes: RoutesBuilder) throws {
        routes.post(Endpoint.API.Users.login, use: login)
    }
}

extension AppUserController.TokenProtected: RouteCollection {
    func showMe(req: Request) throws -> EventLoopFuture<Response> {
        let user = try req.auth.require(AppUser.self)
        return DataWrapper.encodeResponse(data: user, for: req)
    }
    func boot(routes: RoutesBuilder) throws {
        routes.get(Endpoint.API.Users.me, use: showMe)
    }
}


struct Fail: Content {
    var message: String
}
