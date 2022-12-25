import UIKit

class MessangesController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    let api = ApiProcessor()
    
    var chats = [Inbox]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get all user chats
        //chats = api.getAllUserChats()!
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.delegate = self
        table.dataSource = self
    }
    
    @IBAction func onNewMessageButtonClick() {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "test"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    //show chat
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ChatViewController()
        vc.title = "Chat"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
