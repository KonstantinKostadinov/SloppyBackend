//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor
import Foundation

struct AppUserRequest: Content {
    let email: String
    let password: String
    let confirmPassword: String
}

extension AppUserRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(6...))
        validations.add("confirmPassword", as: String.self, is: .count(6...))
    }
}
