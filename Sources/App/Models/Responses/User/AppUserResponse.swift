//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor
import Foundation

struct AppUserResponse: Content {
    var email: String
    var userID: UUID
}
