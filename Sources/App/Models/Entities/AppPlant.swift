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
    
    @Field(key: "name")
    var name: String

    @Field(key: "scientificName")
    var scientificName: String
    
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
        .init(id: self.id!, origin: origin, name: name, scientificName: scientificName, maxGrowth: maxGrowth, poisonousToPets: poisonousToPets, temperature: temperature, light: light, watering: watering, soil: soil, rePotting: rePotting, airHumidity: airHumidity, propagation: propagation, whereItGrowsBest: whereItGrowsBest, potentialProblems: potentialProblems)
    }
    
    init() { }

    init(id: UUID? = nil, origin: String, name: String, scientificName: String, maxGrowth: String, poisonousToPets: String, temperature: String, light: String, watering: String, soil: String, rePotting: String, airHumidity: String, propagation: String, whereItGrowsBest: String, potentialProblems: [String]) {
        self.id = id
        self.origin = origin
        self.name = name
        self.scientificName = scientificName
        self.maxGrowth = maxGrowth
        self.poisonousToPets = poisonousToPets
        self.temperature = temperature
        self.light = light
        self.watering = watering
        self.soil = soil
        self.rePotting = rePotting
        self.airHumidity = airHumidity
        self.propagation = propagation
        self.whereItGrowsBest = whereItGrowsBest
        self.potentialProblems = potentialProblems
    }
}
