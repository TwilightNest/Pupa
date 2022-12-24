import UIKit

class AddFriendController: UIViewController {
    
    let api = ApiProcessor()
    @IBOutlet var friendDataTextField: UITextField!

    
    @IBAction func addFriendButtonClick() {
        let getUserByDataResponse = api.getUserByData(data: friendDataTextField.text!)
        
        switch getUserByDataResponse.0 {
        case 200...299:
            let newFriend = getUserByDataResponse.1
            if api.currentUser.Id == newFriend!.Id{
                AlertHelper.showAlertMessage(title: "Error", message: "You can't add yourself as friend")
                return
            }
            let currentUserFriends = api.getUserFriends(userId:api.currentUser.Id)
            let friendUserFriends = api.getUserFriends(userId:newFriend!.Id)
            currentUserFriends?.FriendsIds.append(newFriend!.Id)
            friendUserFriends?.FriendsIds.append(api.currentUser.Id)
            
            let updateUserFriendsResponseCode = api.updateUserFriends(newUserFriends: currentUserFriends!)
            let updateFriendFriendsResponseCode = api.updateUserFriends(newUserFriends: friendUserFriends!)
            
            if 200...299 ~= updateUserFriendsResponseCode || 200...299 ~= updateFriendFriendsResponseCode{
                WorkspaceHelper.performSegue(parentController: self, segueIdentifier: "unwindToAddFriendSegue")
            }
        case 400...499:
            AlertHelper.showAlertMessage(title: "Error", message: "User not found")
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "WTF???")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //убираем клавиатуру по клику на view
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
