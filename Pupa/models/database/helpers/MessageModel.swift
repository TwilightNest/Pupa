import Foundation

class MessageModel: Codable{
    var chatId : UUID
    var senderUserId: UUID
    var messageBody: String
    var created: String
    
    init(chatId: UUID, senderUserId: UUID, messageBody: String, created: String) {
        self.chatId = chatId
        self.senderUserId = senderUserId
        self.messageBody = messageBody
        self.created = created
    }
    
    init(message: Message) {
        self.chatId = message.chatId
        self.senderUserId = message.senderUserId
        self.messageBody = message.messageBody
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.created = formatter.string(from: message.created)
    }
    
    init(json: Any) {
        let jsonDictionary = json as! [String: Any]
        self.chatId = UUID(uuidString:jsonDictionary["chatId"] as! String)!
        self.senderUserId = UUID(uuidString:jsonDictionary["senderUserId"] as! String)!
        self.messageBody = (jsonDictionary["messageBody"] as! String?)!
        self.created = (jsonDictionary["created"] as? String)!
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
