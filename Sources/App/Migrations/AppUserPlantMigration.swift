//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 30.07.21.
//

import Vapor
import Foundation
import Fluent
import FluentPostgresDriver

struct AppUserPlantMigration: Migration {
    var name: String {"User plant migration"}
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("userPlant")
            .id()
            .field("notes", .string)
            .field("timesPlantIsWatered",.int)
            .field("name", .string)
            .field("lastTimeWatered", .double)
            .field("parentId", .uuid, .references("users", "id"), .required)
            .field("plantMainParent", .string)
            .field("daysToWater", .int)
            .field("assignedToFriendsWithIds", .array(of: .uuid))
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("userPlant").delete()
    }
}
