import Foundation

class Message {
    var id: UUID
    var inboxId : UUID
    var receiverUserId: UUID
    var messageBody: String
    var createdAt: Date
    
    init(id: UUID, inboxId: UUID, receiverUserId: UUID, messageBody: String, createdAt: Date) {
        self.id = id
        self.inboxId = inboxId
        self.receiverUserId = receiverUserId
        self.messageBody = messageBody
        self.createdAt = createdAt
    }
}
