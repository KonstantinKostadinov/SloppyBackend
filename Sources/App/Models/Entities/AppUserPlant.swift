//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 30.07.21.
//

import Vapor
import Foundation
import Fluent

final class AppUserPlant: Model, Content {
    static let schema: String = "userPlant"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "parentId")
    var parentId: UUID

    @Field(key: "notes")
    var notes: String

    @Field(key: "timesPlantIsWatered")
    var timesPlantIsWatered: Int

    @Field(key: "name")
    var name: String

    @Field(key: "lastTimeWatered")
    var lastTimeWatered: Double

    @Field(key: "assignedToFriendsWithIds")
    var assignedToFriendsWithIds: [UUID]

    var newPlantResposne: AppOwnPlantResponse {
        .init(userPlant: self)
    }

    init() {}

    init(id: UUID? = nil, parentId: UUID, notes: String, timesPlantIsWatered: Int, name: String, lastTimeWatered: Double/*, assignedToFriedsWithIds: [UUID]*/) {
        self.id = id
        self.parentId = parentId
        self.notes = notes
        self.timesPlantIsWatered = timesPlantIsWatered
        self.name = name
        self.lastTimeWatered = lastTimeWatered
        self.assignedToFriendsWithIds = [UUID]()
    }
}
