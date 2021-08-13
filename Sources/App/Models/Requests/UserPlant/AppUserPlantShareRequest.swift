//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 11.08.21.
//

import Foundation
import Vapor

struct AppUserPlantShareRequest: Content {
    var email: String
    var plantId: UUID
}
