//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 3.08.21.
//

import Foundation
import Vapor
struct AppPlantRequest: Content {
    var origin: String
    var name: String
    var scientificName: String
    var maxGrowth: String
    var poisonousToPets: String
    var temperature: String
    var light: String
    var watering: String
    var soil: String
    var rePotting: String
    var airHumidity: String
    var propagation: String
    var whereItGrowsBest: String
    var potentialProblems: [String]
}

extension AppPlantRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("origin", as: String.self, is: .count(3...) && .ascii)
        validations.add("name", as: String.self, is: .count(3...) && .ascii)
        validations.add("scientificName", as: String.self, is: .count(3...) && .ascii)
        validations.add("maxGrowth", as: String.self, is: .count(3...) && .ascii)
        validations.add("poisonousToPets", as: String.self, is: .count(3...) && .ascii)
        validations.add("temperature", as: String.self, is: .count(3...) && .ascii)
        validations.add("light", as: String.self, is: .count(3...) && .ascii)
        validations.add("watering", as: String.self, is: .count(3...) && .ascii)
        validations.add("soil", as: String.self, is: .count(3...) && .ascii)
        validations.add("rePotting", as: String.self, is: .count(3...) && .ascii)
        validations.add("airHumidity", as: String.self, is: .count(3...) && .ascii)
        validations.add("propagation", as: String.self, is: .count(3...) && .ascii)
        validations.add("whereItGrowsBest", as: String.self, is: .count(3...) && .ascii)
        validations.add("potentialProblems", as: String.self, is: .count(3...) && .ascii)
    }
}
