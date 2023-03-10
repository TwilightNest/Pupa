import Foundation

class Message: Codable{
    var chatId : UUID
    var senderUserId: UUID
    var messageBody: String
    var created: Date
    
    init() {
        self.chatId = UUID()
        self.senderUserId = UUID()
        self.messageBody = ""
        self.created = Date()
    }
    
    init(messageModel: MessageModel) {
        self.chatId = messageModel.chatId
        self.senderUserId = messageModel.senderUserId
        self.messageBody = messageModel.messageBody
        let formaatter = DateFormatter()
        formaatter.locale = Locale(identifier: "en_US_POSIX")
        formaatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        self.created = formaatter.date(from: messageModel.created)!
    }
    
    init(json: Any) {
        let jsonDictionary = json as! [String: Any]
        self.chatId = UUID(uuidString:jsonDictionary["chatId"] as! String)!
        self.senderUserId = UUID(uuidString:jsonDictionary["senderUserId"] as! String)!
        self.messageBody = (jsonDictionary["messageBody"] as! String?)!
        let dateString = (jsonDictionary["created"] as? String)!
        self.created = DateFormatter().date(from: dateString)!
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
