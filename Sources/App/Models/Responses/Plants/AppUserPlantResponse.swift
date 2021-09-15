//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 10.09.21.
//

import Foundation
import Vapor

struct AppUserPlantResponse: Content {
    var id: UUID
    var parentId: String
    var notes: String
    var timesPlantIsWatered: Int
    var name: String
    var lastTimeWatered: Double
    var daysToWater: Int
    var assignedToFriendsWithIds: [UUID]
}
