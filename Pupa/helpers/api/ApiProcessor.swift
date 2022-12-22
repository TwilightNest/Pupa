import Foundation

class ApiProcessor {
    let baseUrl: String = "http://185.152.139.127"
    let usersUrl: String = "/Users"
    let userLocationsUrl: String = "/UsersLocations"
    let userFriendsUrl: String = "/UserFriends"
    
    var currentUser = User()
    
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
        
        let responseCode = HttpRequester.sendSyncAddUserRequest(urlValue: baseUrl + usersUrl, jsonDictionary: newUser.getJsonDictionary())
        
        return responseCode;
    }
    
    func getUserByData(data: String) -> (Int, User?) {
        let response = HttpRequester.sendSyncGetUserByDataRequest(urlValue: baseUrl + usersUrl, dataParametr: data)
        switch response.0 {
        case 200...299:
            return (response.0, User(json: response.1))
        case 400...499:
            return (response.0, nil)
        default:
            return (0,User())
        }
    }
    
    func getUserLocation(userId: UUID) -> UserLocation {
        let userLocationDictionary = HttpRequester.sendSyncGetUserLocationRequest(urlValue: baseUrl + userLocationsUrl, userId: userId).1
        return UserLocation(json: userLocationDictionary)
    }
    
    func updateUserLocation(newUserLocation: UserLocation) -> Int {
        let responseCode = HttpRequester.sendSyncUpdateUserLocationRequest(urlValue: baseUrl + userLocationsUrl, newUserLocation: newUserLocation)
        return responseCode
    }
    
    func getUserFriends(userId: UUID) -> (Int, UserFriends?) {
        let response = HttpRequester.sendSyncGetUserFriendsRequest(urlValue: baseUrl + userFriendsUrl, userId: userId)
        switch response.0 {
        case 200...299:
            return (response.0, UserFriends(json: response.1))
        case 400...499:
            return (response.0, nil)
        default:
            return (0,UserFriends())
        }
    }
    
    func updateUserFriends(newUserFriends: UserFriends) -> Int {
        let responseCode = HttpRequester.sendSyncUpdateUserFriendsRequest(urlValue: baseUrl + userFriendsUrl, newUserFriends: newUserFriends)
        return responseCode
    }
}
