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

    func addPlant(req: Request) throws -> EventLoopFuture<Response> {
        try AppPlantRequest.validate(content: req)
        let create = try req.content.decode(AppPlantRequest.self)
        let plant = AppPlant(origin: create.origin, name: create.name, scientificName: create.scientificName, maxGrowth: create.maxGrowth, poisonousToPets: create.poisonousToPets, temperature: create.temperature, light: create.light, watering: create.watering, soil: create.soil, rePotting: create.rePotting, airHumidity: create.airHumidity, propagation: create.propagation, whereItGrowsBest: create.whereItGrowsBest, potentialProblems: create.potentialProblems)

        return plant.save(on: req.db).flatMap {
            return DataWrapper.encodeResponse(data: plant.response, for: req)
        }
    }

    func boot(routes: RoutesBuilder) throws {
        routes.get(Endpoint.API.Plants.allPlants, use: fetchAllPlants)
        routes.post(Endpoint.API.Plants.addHousePlant, use: addPlant)
    }
}
