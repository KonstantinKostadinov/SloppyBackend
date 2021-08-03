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

        let user = try AppUser(id: UUID().uuidString, firstName: create.firstName, lastName: create.lastName, email: create.email, passwordHash: Bcrypt.hash(create.password, cost: 10))
        let token = try req.jwt.sign(user)

        return user.save(on: req.db).flatMap {
            let loginResponse = AppUserLoginResponse(user: user.response, accessToken: token)
            return DataWrapper.encodeResponse(data: loginResponse, for: req)
        }
    }

    func boot(routes: RoutesBuilder) throws {
        routes.post(Endpoint.API.Users.register, use: register)
    }
}

extension AppUserController.PasswordProtected: RouteCollection {
    func login(req: Request) throws -> EventLoopFuture<Response> {
        let user = try req.auth.require(AppUser.self)
        let token = try req.jwt.sign(user)
        let loginResponse = AppUserLoginResponse(user: user.response, accessToken: token)
        return DataWrapper.encodeResponse(data: loginResponse, for: req)
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
