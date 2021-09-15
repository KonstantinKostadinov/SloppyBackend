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
        return AppUser.find(user.id, on: req.db).unwrap(or: Abort(.notFound)).flatMap({ appUser in
            return DataWrapper.encodeResponse(data: appUser.ownedAndSharedPlantsReponse, for: req)

        })
    }

    func fetchOwnAndSharedPlants(req: Request) throws -> EventLoopFuture<Response> {
        let user = try req.auth.require(AppUser.self)
        //let plantIds = Set(user.plantIds + user.sharedPlantIds)
        return AppUserPlant.query(on: req.db)
            .all()
            .map { $0.map { $0.newPlantResponse } }
            .flatMap { DataWrapper.encodeResponse(data: $0, for: req) }
//        return AppUserPlant.query(on: req.db).all().map { allPlants in
//            var userPLants = [AppUserPlant]()
//            for plaint in allPlants {
//                if plantIds.contains(plaint.id!) {
//                    userPLants.append(plaint)
//                }
//            }
//            return userPLants
//        }
    }

    func addOwnPlant(req: Request) throws -> EventLoopFuture<Response> {
        let user = try req.auth.require(AppUser.self)
        let reqPlant = try req.content.decode(AppUserPlantCreateRequest.self)
        let uuid = UUID()
        print(uuid)
        let newPlant = AppUserPlant(id: uuid, parentId: reqPlant.parentId, notes: reqPlant.notes, timesPlantIsWatered: reqPlant.timesPlantIsWatered, name: reqPlant.name, lastTimeWatered: reqPlant.lastTimeWatered, daysToWater: reqPlant.daysToWater, plantMainParent: reqPlant.plantMainParent)
        return newPlant.save(on: req.db).flatMap { _ in
            return AppUser.find(user.id ?? UUID(), on: req.db).unwrap(or: Abort(.notFound)).flatMap { dbUser in
                dbUser.plantIds.append(newPlant.id ?? uuid)
                return dbUser.save(on: req.db).flatMap { _ in
                    return DataWrapper.encodeResponse(data: newPlant.newPlantResponse, for: req)
                }
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
                return AppUserPlant.query(on: req.db).filter(\.$id == reqBody.plantId).first().flatMap { (userPlant) in
                    userPlant?.assignedToFriendsWithIds.append(secondUser.id ?? UUID())
                    _ = userPlant?.save(on: req.db)
                    return DataWrapper.encodeResponse(data: ResponseStructure.init(message: "Shared succesfully"), for: req)
                }
            } else {
                return DataWrapper.encodeResponse(data: ResponseStructure.init(message: "No user with this email"), for: req)
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
                return AppUserPlant.query(on: req.db).filter(\.$id == reqBody.plantId).first().flatMap { (userPlant) in
                    userPlant?.assignedToFriendsWithIds.append(secondUser.id ?? UUID())
                    _ = userPlant?.save(on: req.db)
                    return DataWrapper.encodeResponse(data: ResponseStructure.init(message: "UnShared succesfully"), for: req)
                }
            } else {
                return DataWrapper.encodeResponse(data: ResponseStructure.init(message: "No user with this email"), for: req)
            }
        }
    }

    func waterPlant(req: Request) throws -> EventLoopFuture<Response> {
        let plantId = try req.content.decode(PlantID.self)
        return AppUserPlant.query(on: req.db).filter(\.$id == plantId.plantId).first().flatMap { plant in
            if let plant = plant {
                plant.timesPlantIsWatered += 1
                return plant.save(on: req.db).flatMap { _ in
                    return DataWrapper.encodeResponse(data: plant.newPlantResponse, for: req)
                }
            } else {
                return DataWrapper.encodeResponse(data: ResponseStructure.init(message: "Plant with such id not found"), for: req)
            }
        }
    }

    
    func boot(routes: RoutesBuilder) throws {
        routes.get(Endpoint.API.UserPlants.ownedAndSharedPlants, use: fetchOwnAndSharedPlantIds)
        routes.post(Endpoint.API.UserPlants.addOwnPlant, use: addOwnPlant)
        routes.post(Endpoint.API.UserPlants.shareMyPlant, use: sharePlantWithUser)
        routes.post(Endpoint.API.UserPlants.unshareMyPlant, use: unsharePlantWithUser)
        routes.get(Endpoint.API.UserPlants.returnOwnedAndSharedPlants, use: fetchOwnAndSharedPlants)
        routes.post(Endpoint.API.UserPlants.waterPlant, use: waterPlant)
    }
}

struct PlantID: Content {
    var plantId: UUID
}
