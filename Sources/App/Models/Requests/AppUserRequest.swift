//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor
import Foundation

struct AppUserRequest: Content {
    let username: String
    let firstName: String
    let lastName: String
    let password: String
    let confirmPassword: String
}

extension AppUserRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: .alphanumeric)
        validations.add("firstName", as: String.self, is: .count(3...) && .ascii)
        validations.add("lastName", as: String.self, is: .count(3...) && .ascii)
        validations.add("password", as: String.self, is: .count(6...))
    }
}
