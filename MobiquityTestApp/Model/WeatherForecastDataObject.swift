//
//  WeatherForecastData.swift
//  MobiquityTestApp
//
//  Created by Sandy Gangireddi on 11/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import Foundation

struct WeatherForecastDataObject: Decodable {
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [ListItemObject]?
    var city: CityObject?
}
