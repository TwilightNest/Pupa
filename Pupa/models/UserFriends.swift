import Foundation

class UserFriends : Codable {
    var UserId: UUID = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    var FriendsIds: [UUID]

    init(){
        FriendsIds = [UUID()]
    }
    
    init(json: [String: Any]) {
        self.UserId = UUID(uuidString: (json["userId"] as? String)!)!
        let friendsIdsStringArray = (json["friendsIds"] as? Array<String>)!
        var tmp = [UUID]()
        for id in friendsIdsStringArray {
            tmp.append(UUID(uuidString: id)!)
        }
        self.FriendsIds = tmp
    }
}
