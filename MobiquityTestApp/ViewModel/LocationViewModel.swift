
import Foundation
import UIKit

struct LocationViewModel {
    
    let countryName: String
    let locationName: String
    let address: String
    let latitude: String
    let longitude: String
    
    // Dependency Injection (DI)
    init(location: Location) {
        self.countryName = location.country ?? ""
        self.locationName = location.locationName ?? ""
        self.address = location.address ?? ""
        self.latitude = location.latitude ?? ""
        self.longitude = location.longitude ?? ""
    }
    
}
