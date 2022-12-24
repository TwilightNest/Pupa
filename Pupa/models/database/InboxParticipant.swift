import Foundation

class InboxParticipant {
    var id: UUID
    var senderUserId: UUID
    var inboxId: UUID
    
    init(id: UUID, senderUserId: UUID, inboxId: UUID) {
        self.id = id
        self.senderUserId = senderUserId
        self.inboxId = inboxId
    }
}
