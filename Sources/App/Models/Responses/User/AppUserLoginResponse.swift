//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor

struct AppUserLoginResponse: Content {
    let user: AppUserFullResponse
    let accessToken: String
}
