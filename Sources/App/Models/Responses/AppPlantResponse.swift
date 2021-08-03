//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor
import Foundation

struct AppPlantResponse: Content {
    var origin: String
    var names: String
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