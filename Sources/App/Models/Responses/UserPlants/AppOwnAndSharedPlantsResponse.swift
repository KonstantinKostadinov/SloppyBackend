//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 11.08.21.
//

import Foundation
import Vapor

struct AppOwndAndSharedPlantsResponse: Content {
    var plantIds: [UUID]
    var sharedPlantIds: [UUID]
}
