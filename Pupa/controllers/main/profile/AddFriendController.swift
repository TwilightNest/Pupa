import UIKit

class AddFriendController: UIViewController {
    
    let api = ApiProcessor()
    @IBOutlet var friendDataTextField: UITextField!

    
    @IBAction func addFriendButtonClick() {
        let getUserByDataResponse = api.getUserByData(data: friendDataTextField.text!)
        
        let responseCode = getUserByDataResponse.0
        let newFriend = getUserByDataResponse.1
        
        switch responseCode{
        case 200...299:
            if api.currentUser.Id == newFriend!.Id{
                AlertHelper.showAlertMessage(title: "Error", message: "You can't add yourself as friend")
                return
            }
            
            let newUserRelationship = Relationship(userId: api.currentUser.Id, friendId: newFriend!.Id, statisticsID: UUID())
            let newFriendRelationship = Relationship(userId: newFriend!.Id, friendId: api.currentUser.Id, statisticsID: UUID())
            
            if uploadRelationship(newRelationship: newUserRelationship) && uploadRelationship(newRelationship: newFriendRelationship){
                WorkspaceHelper.performSegue(parentController: self, segueIdentifier: "unwindToAddFriendSegue")
            }
        case 400...499:
            AlertHelper.showAlertMessage(title: "Error", message: "User not found")
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "WTF???")
        }
        
        func uploadRelationship(newRelationship: Relationship) -> Bool{
            let URResponseCode = api.addRelationship(newRelationship: newRelationship)
            
            switch URResponseCode{
            case 200...299:
                return true
            default:
                AlertHelper.showAlertMessage(title: "Error", message: "at uploadRelationship, response code = \(URResponseCode)")
                return false
            }
        }
        
        func uploadStatistic(newStatistic: Statistic) -> Bool{
            let USResponse = api.addStatistic(newStatisticModel: StatisticModel(statistic: newStatistic))
            switch USResponse{
            case 200...299:
                return true
            default:
                AlertHelper.showAlertMessage(title: "Error", message: "at uploadStatistics, response code = \(USResponse)")
                return false
            }
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
