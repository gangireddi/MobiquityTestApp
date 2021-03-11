//
//  CityObject.swift
//  MobiquityTestApp
//
//  Created by Sandy Gangireddi on 11/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import Foundation

struct CityObject: Decodable {
    
    var id: Int?
    var name: String?
    var coord: CoordObject?
    var country: String?
    var population: Int?
    var timezone: Int?
    var sunrise: Int?
    var sunset: Int?
}

struct CoordObject: Decodable {
    var lat: Double?
    var lon: Double?
}
