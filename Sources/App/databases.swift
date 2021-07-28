//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Fluent
import FluentPostgresDriver
import Vapor

func databases(databases: Databases) {
    databases.use(
        .postgres(
            hostname: Environment.get("DATABASE_HOST")!,
            username: Environment.get("DATABASE_USERNAME")!,
            password: Environment.get("DATABASE_PASSWORD")!,
            database: Environment.get("DATABASE_NAME")!
        ),
        as: .psql
    )
}

