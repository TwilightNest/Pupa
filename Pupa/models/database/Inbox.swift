import Foundation

class Inbox {
    var id: UUID
    var lastMessage: String
    var lastSentUserId: UUID
    
    init(id: UUID, lastMessage: String, lastSentUserId: UUID) {
        self.id = id
        self.lastMessage = lastMessage
        self.lastSentUserId = lastSentUserId
    }
}
