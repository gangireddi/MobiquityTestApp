//
//  ListItemObject.swift
//  MobiquityTestApp
//
//  Created by Sandy Gangireddi on 11/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import Foundation

struct ListItemObject: Decodable {
    
    var main: MainObject?
    var weather: [WeatherObject]?
    var clouds: [String: Int]?
    var wind: WindObject?
    var visibility: Int?
    var pop: Double?
    var sys: [String: String]?
    var dt_txt: String?
}

struct MainObject: Decodable {
    
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var sea_level: Int?
    var grnd_level: Int?
    var humidity: Int?
    var temp_kf: Double?
}

struct WeatherObject: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct WindObject: Decodable {
    var speed: Double?
    var deg: Int?
}
