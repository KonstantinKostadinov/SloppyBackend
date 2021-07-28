//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Fluent

func migrate(migrations: Migrations) {
    migrations.add(AppUserMigration())
    migrations.add(AppPlantMigration())
}
