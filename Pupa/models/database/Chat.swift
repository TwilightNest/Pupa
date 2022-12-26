import Foundation

class Chat: Codable{
    var id: UUID
    var lastMessage: String
    var lastSenderUserId: UUID
    
    init(id: UUID, lastMessage: String, lastSenderUserId: UUID) {
        self.id = id
        self.lastMessage = lastMessage
        self.lastSenderUserId = lastSenderUserId
    }
}
