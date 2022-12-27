import Foundation

class ChatModel: Codable{
    var id: UUID
    var lastMessage: String
    var lastSenderUserId: UUID
    var firstUserId: UUID
    var secondUserId: UUID
    
    init(){
        id = UUID.init(uuidString: "00000000-0000-0000-0000-000000000000")!
        lastMessage = ""
        lastSenderUserId = UUID.init(uuidString: "00000000-0000-0000-0000-000000000000")!
        firstUserId = UUID.init(uuidString: "00000000-0000-0000-0000-000000000000")!
        secondUserId = UUID.init(uuidString: "00000000-0000-0000-0000-000000000000")!
    }
    
    init(id: UUID, lastMessage: String, lastSenderUserId: UUID,firstUserId: UUID, secondUserId: UUID) {
        self.id = id
        self.lastMessage = lastMessage
        self.lastSenderUserId = lastSenderUserId
        self.firstUserId = firstUserId
        self.secondUserId = secondUserId
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
