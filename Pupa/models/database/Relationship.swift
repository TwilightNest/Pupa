import Foundation

class Relationship: Codable {
    var userId: UUID
    var friendId: UUID
    var statisticsID: UUID?
    
    init(userId: UUID, friendId: UUID, statisticsID: UUID) {
        self.userId = userId
        self.friendId = friendId
        self.statisticsID = statisticsID
    }
    
    init(json: Any){
        let jsonDictionary = json as! [String: Any]
        self.userId = UUID(uuidString: (jsonDictionary["userId"] as? String)!)!
        self.friendId = UUID(uuidString: (jsonDictionary["friendId"] as? String)!)!
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
