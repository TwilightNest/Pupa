import Foundation

class StatisticModel: Codable {
    var id: UUID
    var relationType: Int16
    var timeTogether: Int
    var firstMetDate: String
    var messagesCount: Int64
    var meetingsCount: Int
    
    init() {
        self.id = UUID()
        self.relationType = 0
        self.timeTogether = 0
        self.firstMetDate = DateFormatter().string(from: Date())
        self.messagesCount = 0
        self.meetingsCount = 0
    }
    
    init(statistic: Statistic) {
        self.id = statistic.id
        self.relationType = statistic.relationType
        self.timeTogether = statistic.timeTogether
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.firstMetDate = formatter.string(from: statistic.firstMetDate)
        self.messagesCount = statistic.messagesCount
        self.meetingsCount = statistic.meetingsCount
    }
    
    init(json: Any) {
        let jsonDictionary = json as! [String: Any]
        self.id = UUID(uuidString: (jsonDictionary["id"] as? String)!)!
        self.relationType = (jsonDictionary["relationType"] as? Int16)!
        self.timeTogether = (jsonDictionary["timeTogether"] as? Int)!
        self.firstMetDate = (jsonDictionary["firstMetDate"] as? String)!
        self.messagesCount = (jsonDictionary["messagesCount"] as? Int64)!
        self.meetingsCount = (jsonDictionary["meetingsCount"] as? Int)!
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
