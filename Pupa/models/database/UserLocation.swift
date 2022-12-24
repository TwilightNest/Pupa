import Foundation
import CoreLocation

class UserLocation : Codable {
    var UserId: UUID
    var Latitude: Double
    var Longitude: Double
    
    init(UserId: UUID, Latitude: Double, Longitude: Double) {
        self.UserId = UserId
        self.Latitude = Latitude
        self.Longitude = Longitude
    }
    
    init(json: Any) {
        let jsonDictionary = json as! [String: Any]
        self.UserId = UUID(uuidString: (jsonDictionary["userId"] as? String)!)!
        self.Latitude = jsonDictionary["latitude"] as! Double
        self.Longitude = jsonDictionary["longitude"] as! Double
    }
    
    func toJson() -> Any {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return jsonData
    }
    
    func toCLLocation() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Latitude, longitude: Longitude)
    }
    
    func toString() -> String {
        return "Latitude: \(String(describing: Latitude)) Longitude: \(String(describing: Longitude))"
    }
}
