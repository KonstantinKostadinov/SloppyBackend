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



import Vapor

extension Environment {
    
    static var databaseURL: URL {
        guard let /*urlString = Environment.get("DATABASE_URL"), let*/ url = URL(string: "postgres://fenqpjyaheauxq:2e558fb1a2987e3a35e586babb629200a327b4332f1fac5c96779522f6c8dd68@ec2-54-74-95-84.eu-west-1.compute.amazonaws.com:5432/d47ejqmu6n5tg4") else {
            fatalError("DATABASE_URL not configured")
        }
        return url
    }
}
