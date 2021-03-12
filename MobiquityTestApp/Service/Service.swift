import Foundation

class Service: NSObject {
    static let shared = Service()
    
    func fetchData(lat:String,lon: String,units: String, completion: @escaping (WeatherForecastDataObject?, Error?) -> ()) {
        let urlString = String(format: BASE_URL, lat,lon,API_KEY,units)
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch weather data:", err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let responseDataObject = try JSONDecoder().decode(WeatherForecastDataObject.self, from: data)
                DispatchQueue.main.async {
                    completion(responseDataObject, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
}
