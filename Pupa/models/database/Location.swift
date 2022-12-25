import Foundation
import CoreLocation

class Location : Codable {
    var userId: UUID
    var latitude: Double
    var longitude: Double
    
    init(objectId: UUID, latitude: Double, longitude: Double){
        self.userId = objectId
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(json: Any) {
        let jsonDictionary = json as! [String: Any]
        self.userId = UUID(uuidString: (jsonDictionary["userId"] as? String)!)!
        self.latitude = jsonDictionary["latitude"] as! Double
        self.longitude = jsonDictionary["longitude"] as! Double
    }
    
    func toJson() -> Any {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return jsonData
    }
    
    func toData() -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return jsonData
    }
    
    func toCLLocation() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func toString() -> String {
        return "Latitude: \(String(describing: latitude)) Longitude: \(String(describing: longitude))"
    }
}
