import UIKit

class MessengerController: UITableViewController {
    
    @IBOutlet var chatsTableView: UITableView!
    
    var userChats = [Chat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatsTableView.delegate = self
        chatsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateChats()
    }
    
    @IBAction func onNewChatButtonClick() {
        addNewChat()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return userChats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatsTableView.dequeueReusableCell(withIdentifier: "chat", for: indexPath)
        
        // get second chat user
        var chatUsers = api.getChatUsers(chatId: userChats[indexPath.row].id)
        chatUsers?.removeAll(where: { user in
            user.Id == api.currentUser!.Id
        })
        
        let friendName = chatUsers?.first?.Login
        cell.textLabel?.text = friendName
        return cell
    }
    
    //show chat
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatViewController()
        vc.chatId = userChats[indexPath.row].id
        
        // get second chat user
        var chatUsers = api.getChatUsers(chatId: userChats[indexPath.row].id)
        chatUsers?.removeAll(where: { user in
            user.Id == api.currentUser!.Id
        })
        
        vc.title = chatUsers?.first?.Login
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addNewChat() {
        let newChatModel = ChatModel()
        newChatModel.firstUserId = api.currentUser!.Id
        newChatModel.secondUserId = api.getUserRelationships(userId: api.currentUser!.Id)![0].friendId
        let responseCode = api.addChat(newChatModel: newChatModel)
        switch responseCode {
        case 200...299:
            updateChats()
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at addNewChat, response code = \(responseCode)")
        }
    }
    
    func updateChats() {
        userChats = api.getUserChats(userId: api.currentUser!.Id)!
        chatsTableView.reloadData()
    }
}
