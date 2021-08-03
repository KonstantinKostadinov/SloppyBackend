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
        return database.schema("users").field("id", .uuid).field("firstName", .string, .required).field("lastName",.string,.required).field("username", .string , .required).field("passwordHash",.string,.required).field("plantIds", .array(of: .string)).unique(on: "username").create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete()
    }
}
