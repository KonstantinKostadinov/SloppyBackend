//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 11.08.21.
//

import Foundation
import Vapor

struct AppUserPlantCreateRequest: Content {
    var name: String
    var notes: String
    var lastTimeWatered: Double
    var timesPlantIsWatered: Int
    var assignedToFriendsWithIds: [UUID]
    var parentId: UUID
}
