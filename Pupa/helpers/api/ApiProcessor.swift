import Foundation

class ApiProcessor {
    let baseUrl: String = "http://185.152.139.127"
    let usersUrl: String = "/Users"
    let userLocationsUrl: String = "/UsersLocations"
    let userFriendsUrl: String = "/UserFriends"
    let inboxPaticipantsUrl: String = "/InboxPaticipants"
    
    var currentUser: User!
    
    init(){
        do {
            let data = UserDefaults.standard.data(forKey:"CurrentUser")
            if data != nil{
                currentUser = try JSONDecoder().decode(User.self,from:data!)
            }
        }
        catch { print(error) }
    }
    
    func registerNewUser(newUser: User) -> Int {
        let responseCode = HttpRequester.sendSyncPostRequest(urlValue: baseUrl + usersUrl, dataToPost: newUser.toData())
        
        return responseCode;
    }
    
    func getUserByData(data: String) -> (Int, User?) {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + usersUrl, parametr: data)
        let responseCode = response.0
        let responseJson = response.1
        switch responseCode {
        case 200...299:
            return (response.0, User(json: responseJson!))
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getUserByData, response code = \(responseCode)")
            return (0, nil)
        }
    }
    
    func getUserLocation(userId: UUID) -> UserLocation? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + userLocationsUrl, parametr: userId.uuidString)
        
        let responseCode = response.0
        let responseJson = response.1
        
        switch responseCode {
        case 200...299:
            return UserLocation(json: responseJson!)
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getUserLocation, response code = \(responseCode)")
            return nil
        }
    }
    
    func updateUserLocation(newUserLocation: UserLocation) -> Int {
        let responseCode = HttpRequester.sendSyncPutRequest(urlValue: baseUrl + userLocationsUrl, dataToPut: newUserLocation.toJson())
        return responseCode
    }
    
    func getUserFriends(userId: UUID) -> UserFriends? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + userFriendsUrl, parametr: userId.uuidString)
        
        let responseCode = response.0
        let responseJson = response.1
        
        switch responseCode {
        case 200...299:
            return UserFriends(json: responseJson!)
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getUserFriends, response code = \(responseCode)")
            return nil
        }
    }
    
    func updateUserFriends(newUserFriends: UserFriends) -> Int {
        let responseCode = HttpRequester.sendSyncPutRequest(urlValue: baseUrl + userFriendsUrl, dataToPut: newUserFriends.toJson())
        return responseCode
    }
    
    func getAllUserChats(userId: UUID) -> [Inbox]? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + inboxPaticipantsUrl, parametr: userId.uuidString)
        
        let responseCode = response.0
        let responseJson = response.1
        
        switch responseCode {
        case 200...299:
            return nil
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getUserFriends, response code = \(responseCode)")
            return nil
        }
    }
}
