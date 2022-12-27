import UIKit

class ProfileController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = api.currentUser?.Login
    }
    
    @IBAction func unwindToAddFriend(segue: UIStoryboardSegue){
        AlertHelper.showAlertMessage(title: "OK", message: "You successfully add friend")
    }
    
    @IBAction func logOutButtonClick() {
        UserDefaults.standard.removeObject(forKey: "CurrentUser")
        api.currentUser = nil
        map.deinitLocationManager()
        view.window?.rootViewController = WorkspaceHelper.switchStoryboard(sbName: "Auth", controllerName: "Auth")
    }
}
