//
//  Constants.swift
//  MobiquityTestApp
//
//  Created by Sandy Gangireddi on 11/03/21.
//  Copyright © 2021 Sandy. All rights reserved.
//

import Foundation
import UIKit
import CoreData


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let API_CODE = "fae7190d7e6433ec3a45285ffcf55c86"
let BASE_URL = "http://api.openweathermap.org/data/2.5/forecast?lat=%@&lon=%@&appid=%@&units=%@"
let IMPERIAL = "imperial"
let METRIC = "metric"

let ENTITY_LOCATIONS = "Locations"

let ENTITY_ATTR_ADDRESS = "address"
let ENTITY_ATTR_LATITUDE = "latitude"
let ENTITY_ATTR_LONGITUDE = "longitude"
let ENTITY_ATTR_LOCATION_NAME = "locationName"
let ENTITY_ATTR_COUNTRY = "country"
