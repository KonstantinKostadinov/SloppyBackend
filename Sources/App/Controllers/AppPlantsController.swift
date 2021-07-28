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

struct AppPlantsController {
    struct TokenProtected {}
}

extension AppPlantsController.TokenProtected: RouteCollection {
    func fetchAllPlants(req: Request) throws -> EventLoopFuture<Response> {
        return AppPlant.query(on: req.db)
            .all()
            .map { $0.map { $0.response } }
            .flatMap { DataWrapper.encodeResponse(data: $0, for: req) }
    }

    func boot(routes: RoutesBuilder) throws {
        routes.get(Endpoint.API.Plants, use: fetchAllPlants)
    }
}
