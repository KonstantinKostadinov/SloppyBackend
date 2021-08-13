//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 8.08.21.
//

import Foundation
import Vapor

struct AppUserRegisterResponse: Content {
    let user: AppUserResponse
    let accessToken: String
}
