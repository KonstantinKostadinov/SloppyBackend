//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor
import Foundation

struct Endpoint{
    enum API{}
}

extension Endpoint.API {
    static private let api: [PathComponent] = ["backend"]

    enum Users {
        static private let users: [PathComponent] = api + ["users"]
        static let register: [PathComponent] = users + ["register"]
        static let login: [PathComponent] = users + ["login"]
        static let me: [PathComponent] = users + ["me"]
        static let showAllUsers: [PathComponent] = users + ["showAll"]
    }

    enum Plants {
        static private let plants: [PathComponent] = api + ["plants"]
        static let allPlants: [PathComponent] = plants + ["all"]
        static let addMainPlant: [PathComponent] = plants + ["addMainPlant"]
    }

    enum UserPlants {
        static private let userPlants: [PathComponent] = api + ["userPlants"]
        static let ownedAndSharedPlants: [PathComponent] = userPlants + ["ownedAndSharedPlants"]
        static let addOwnPlant: [PathComponent] = userPlants + ["addOwnPlant"]
        static let shareMyPlant: [PathComponent] = userPlants + ["shareMyPlant"]
        static let deleteMyPlant: [PathComponent] = userPlants + ["deleteMyPlant"]
        static let unshareMyPlant: [PathComponent] = userPlants + ["unshareMyPlant"]
        static let returnOwnedAndSharedPlants: [PathComponent] = userPlants + ["returnOwnedAndSharedPlants"]
        static let waterPlant: [PathComponent] = userPlants + ["waterPlant"]
    }
}
