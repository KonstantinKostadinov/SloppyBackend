//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 1.08.21.
//

import Foundation

import Vapor
import Foundation

struct AppUserFullResponse: Content {
    var email: String
    var firstName: String
    var lastName: String
    var userID: String
    var plaintIds: [String]
    var sharedPlantIds: [String]
}
