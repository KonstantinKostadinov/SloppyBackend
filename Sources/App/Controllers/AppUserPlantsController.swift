//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 11.08.21.
//

import Vapor
import Foundation
import Fluent
import JWT

struct AppUserPlantsController {
    struct TokenProtected {}
}

extension AppUserPlantsController.TokenProtected: RouteCollection {
    func fetchOwnAndSharedPlantIds(req: Request) throws -> EventLoopFuture<Response> {
        let user = try req.auth.require(AppUser.self)
        return DataWrapper.encodeResponse(data: user.ownedAndSharedPlantsReponse, for: req)
    }

    func addOwnPlant(req: Request) throws -> EventLoopFuture<Response> {
        let user = try req.auth.require(AppUser.self)
        let reqPlant = try req.content.decode(AppUserPlantCreateRequest.self)
        let uuid = UUID()
        print(uuid)
        let newPlant = AppUserPlant(id: uuid, parentId: reqPlant.parentId, notes: reqPlant.notes, timesPlantIsWatered: reqPlant.timesPlantIsWatered, name: reqPlant.name, lastTimeWatered: reqPlant.lastTimeWatered)
       
//        return newPlant.save(on: req.db).flatMap { _ in
//            guard let id = newPlant.id else {
//                return DataWrapper.encodeResponse(data: Fail.init(message: "mng kur"), for: req)
//            }
//            user.plantIds.append(id)
//            return user.save(on: req.db).flatMap {
//                return DataWrapper.encodeResponse(data: newPlant.newPlantResposne, for: req)
//
//            }
//
//        }
        _ = newPlant.save(on: req.db)
        return AppUserPlant.query(on: req.db).filter(\.$id == uuid).first().flatMap { (plant) in
            if let plant = plant {
                user.plantIds.append(uuid)
                _ = user.save(on: req.db)
                return DataWrapper.encodeResponse(data: newPlant.newPlantResposne, for: req)
                    
                //}
            } else {
                return DataWrapper.encodeResponse(data: Fail.init(message: "failed to add plant to user"), for: req)
            }
        }
    }

    func sharePlantWithUser(req: Request) throws -> EventLoopFuture<Response> {
        let user = try req.auth.require(AppUser.self)
        let reqBody = try req.content.decode(AppUserPlantShareRequest.self)
        return  AppUser.query(on: req.db).filter(\.$email == reqBody.email).first().flatMap { (appUser) in
            if let secondUser = appUser {
                secondUser.sharedPlantIds.append(reqBody.plantId)
                _ = secondUser.save(on: req.db)
                return DataWrapper.encodeResponse(data: Fail.init(message: "Shared succesfully"), for: req)
            } else {
                return DataWrapper.encodeResponse(data: Fail.init(message: "No user with this email"), for: req)
            }
        }
    }

    func unsharePlantWithUser(req: Request) throws -> EventLoopFuture<Response> {
        let user = try req.auth.require(AppUser.self)
        let reqBody = try req.content.decode(AppUserPlantShareRequest.self)
        return  AppUser.query(on: req.db).filter(\.$email == reqBody.email).first().flatMap { (appUser) in
            if let secondUser = appUser {
                let index = secondUser.sharedPlantIds.firstIndex(of: reqBody.plantId) ?? 0
                secondUser.sharedPlantIds.remove(at: index)
                _ = secondUser.save(on: req.db)
                return DataWrapper.encodeResponse(data: Fail.init(message: "UnShared succesfully"), for: req)
            } else {
                return DataWrapper.encodeResponse(data: Fail.init(message: "No user with this email"), for: req)
            }
        }
    }

    
    func boot(routes: RoutesBuilder) throws {
        routes.get(Endpoint.API.UserPlants.ownedAndSharedPlants, use: fetchOwnAndSharedPlantIds)
        routes.post(Endpoint.API.UserPlants.addOwnPlant, use: addOwnPlant)
        routes.post(Endpoint.API.UserPlants.shareMyPlant, use: sharePlantWithUser)
        routes.post(Endpoint.API.UserPlants.unshareMyPlant, use: unsharePlantWithUser)
    }
}