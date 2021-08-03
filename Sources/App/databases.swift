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
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            username: Environment.get("DATABASE_USERNAME") ?? "lilkosi",
            password: Environment.get("DATABASE_PASSWORD") ?? "",
            database: Environment.get("DATABASE_NAME") ?? "planty_backend"
        ),
        as: .psql
    )
}

