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

struct AppPlantMigration: Migration {
    var name: String {"Plants migration"}
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("plants").field("id", .uuid).field("origin", .string, .required).field("name",.string,.required).field("scientificName", .string, .required).field("maxGrowth", .string , .required).field("poisonousToPets",.string,.required).field("temperature",.string,.required).field("light",.string,.required).field("watering",.string,.required).field("soil",.string,.required).field("rePotting",.string,.required).field("airHumidity",.string,.required).field("propagation",.string,.required).field("whereItGrowsBest",.string,.required).field("potentialProblems",.array(of: .string),.required).create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("plants").delete()
    }
}
