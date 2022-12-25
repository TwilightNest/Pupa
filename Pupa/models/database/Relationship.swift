import Foundation

class Relationship: Codable {
    var firstUserId: UUID
    var secondUserId: UUID
    var statisticsID: UUID
    
    init(firstUserId: UUID, secondUserId: UUID, statisticsID: UUID) {
        self.firstUserId = firstUserId
        self.secondUserId = secondUserId
        self.statisticsID = statisticsID
    }
    
    init(json: Any){
        let jsonDictionary = json as! [String: Any]
        self.firstUserId = UUID(uuidString: (jsonDictionary["firstUserId"] as? String)!)!
        self.secondUserId = UUID(uuidString: (jsonDictionary["secondUserId"] as? String)!)!
        self.statisticsID = UUID(uuidString: (jsonDictionary["statisticsId"] as? String)!)!
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
}
