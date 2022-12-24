import Foundation

class UserFriends : Codable {
    var UserId: UUID
    var FriendsIds: [UUID]
    
    init(json: Any) {
        let jsonDictionary = json as! [String: Any]
        self.UserId = UUID(uuidString: (jsonDictionary["userId"] as? String)!)!
        let friendsIdsStringArray = (jsonDictionary["friendsIds"] as? Array<String>)!
        var tmp = [UUID]()
        for id in friendsIdsStringArray {
            tmp.append(UUID(uuidString: id)!)
        }
        self.FriendsIds = tmp
    }
    
    func toJson() -> Any {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return jsonData
    }
}
