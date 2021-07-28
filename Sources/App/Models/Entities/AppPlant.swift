//
//  File.swift
//  
//
//  Created by Konstantin Kostadinov on 28.07.21.
//

import Vapor
import Foundation
import Fluent
import JWT

final class AppPlant: Model, Content {
    static let schema: String = "plants"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "origin")
    var origin: String
    
    @Field(key: "names")
    var names: String
    
    @Field(key: "maxGrowth")
    var maxGrowth: String
    
    @Field(key: "poisonousToPets")
    var poisonousToPets: String
    
    @Field(key: "temperature")
    var temperature: String
    
    @Field(key: "light")
    var light: String
    
    @Field(key: "watering")
    var watering: String
    
    @Field(key: "soil")
    var soil: String
    
    @Field(key: "rePotting")
    var rePotting: String
    
    @Field(key: "airHumidity")
    var airHumidity: String
    
    @Field(key: "propagation")
    var propagation: String
    
    @Field(key: "whereItGrowsBest")
    var whereItGrowsBest: String
    
    @Field(key: "potentialProblems")
    var potentialProblems: [String]
    
    var response: AppPlantResponse {
        .init(origin: origin, names: names, maxGrowth: maxGrowth, poisonousToPets: poisonousToPets, temperature: temperature, light: light, watering: watering, soil: soil, rePotting: rePotting, airHumidity: airHumidity, propagation: propagation, whereItGrowsBest: whereItGrowsBest, potentialProblems: potentialProblems)
    }
    
    init() { }

}
