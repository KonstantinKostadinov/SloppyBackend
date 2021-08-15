//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor
import Foundation
import Fluent
import FluentPostgresDriver

struct AppUserMigration: Migration {
    var name: String {"Users migration"}
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users")
            .id()
            .field("email", .string , .required)
            .field("passwordHash",.string,.required)
            .field("plantIds", .array(of: .uuid))
            .field("sharedPlantIds", .array(of: .uuid))
            .unique(on: "email")
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete()
    }
}
