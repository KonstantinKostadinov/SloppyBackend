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
    var id: String?

    @Field(key: "notes")
    var notes: String

    @Field(key: "timesPlantIsWatered")
    var timesPlantIsWatered: Int

    @Field(key: "assignedToFriendsWithIds")
    var assignedToFriendsWithIds: [String]
}
