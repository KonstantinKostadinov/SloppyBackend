//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 7.08.21.
//

import Foundation
import Vapor

struct AppUserLoginRequest: Content {
    let email: String
    let password: String
}

extension AppUserLoginRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(6...))
    }
}
