import Foundation

class Statistic: Codable {
    var id: UUID
    var relationType: Int16
    var timeTogether: Int
    var firstMetDate: Date
    var messagesCount: Int64
    var meetingsCount: Int
    
    init() {
        self.id = UUID()
        self.relationType = 0
        self.timeTogether = 0
        self.firstMetDate = Date()
        self.messagesCount = 0
        self.meetingsCount = 0
    }
    
    init(statisticModel: StatisticModel) {
        self.id = statisticModel.id
        self.relationType = statisticModel.relationType
        self.timeTogether = statisticModel.timeTogether
        self.firstMetDate = DateFormatter().date(from: statisticModel.firstMetDate)!
        self.messagesCount = statisticModel.messagesCount
        self.meetingsCount = statisticModel.meetingsCount
    }
    
    init(json: Any) {
        let jsonDictionary = json as! [String: Any]
        self.id = UUID(uuidString: (jsonDictionary["id"] as? String)!)!
        self.relationType = (jsonDictionary["relationType"] as? Int16)!
        self.timeTogether = (jsonDictionary["timeTogether"] as? Int)!
        let dateString = (jsonDictionary["firstMetDate"] as? String)!
        self.firstMetDate = DateFormatter().date(from: dateString)!
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
