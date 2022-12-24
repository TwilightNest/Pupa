import UIKit
import MessageKit

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate{
    
    let currentUser = MKSender(senderId: "uuiduser1", displayName: "testuser1")
    
    let otherUser = MKSender(senderId: "uuiduser2", displayName: "testuser2")
    
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages.append(MKMessage(sender: currentUser,
                                messageId: "uuidmessage1",
                                sentDate: Date().addingTimeInterval(-10),
                                kind: .text("hi user 2")))
        messages.append(MKMessage(sender: otherUser,
                                messageId: "uuidmessage2",
                                sentDate: Date().addingTimeInterval(-5),
                                kind: .text("hi user 1")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    func currentSender() -> MessageKit.SenderType {
        return currentUser;
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        messages.count
    }
    
}
