//
//  Course.swift
//  MVC
//
//  Created by Brian Voong on 6/30/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import Foundation

struct Location {
    var address: String?
    var latitude: String?
    var longitude: String?
    var locationName: String?
    var country: String?
    
    init(address: String,latitude: String,longitude: String,locationName: String,country: String ) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.locationName = locationName
        self.country = country
    }
}
