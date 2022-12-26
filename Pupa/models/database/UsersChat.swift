import Foundation

class UsersChat: Codable{
    var userd: UUID
    var chatId: UUID
    
    init(userd: UUID, chatId: UUID) {
        self.userd = userd
        self.chatId = chatId
    }
}
