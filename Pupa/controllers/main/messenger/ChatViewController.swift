import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate{
    
    var chatId = UUID()
    var chatUsers: Array<User> = []
    var messages = [Message]()
    
    var MKCurrentUser: MKSender! = nil
    var MKOtherUser: MKSender! = nil
    var MKMessages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatUsers = api.getChatUsers(chatId: chatId)!
        chatUsers.forEach({ user in
            if user.Id == api.currentUser?.Id{
                MKCurrentUser = MKSender(senderId: user.Id.uuidString, displayName: user.Login)
            } else {
                MKOtherUser = MKSender(senderId: user.Id.uuidString, displayName: user.Login)
            }
        })
        
        messages = api.getChatMessages(chatId: chatId)!
        messages.forEach({ message in
            if message.senderUserId == api.currentUser?.Id{
                MKMessages.append(MKMessage(sender: MKCurrentUser, messageId: UUID().uuidString, sentDate: message.created, kind: .text(message.messageBody)))
            } else {
                MKMessages.append(MKMessage(sender: MKOtherUser, messageId: UUID().uuidString, sentDate: message.created, kind: .text(message.messageBody)))
            }
        })
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
        messagesCollectionView.reloadData()
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        var newMessage = Message()
        newMessage.chatId = chatId
        newMessage.senderUserId = api.currentUser!.Id
        newMessage.messageBody = text
        newMessage.created = Date()
        let newMKMessage = MKMessage(sender: MKCurrentUser, messageId: UUID().uuidString, sentDate: Date(), kind: .text(text))
        
        let resposeCode = api.addMessage(newMessage: newMessage)
        switch resposeCode{
        case 200...299:
            messages.append(newMessage)
            MKMessages.append(newMKMessage)
            messagesCollectionView.reloadData()
        default:
            AlertHelper.showAlertMessage(title: "Send message error", message: "responseCode = \(resposeCode)")
        }
    }
    
    func currentSender() -> MessageKit.SenderType {
        return MKCurrentUser;
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return MKMessages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        MKMessages.count
    }
}
