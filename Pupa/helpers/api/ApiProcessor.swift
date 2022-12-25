import Foundation

class ApiProcessor {
    let baseUrl: String = "http://185.152.139.127"
    let usersUrl: String = "/Users"
    
    let locationsUrl: String = "/Locations"
    
    let relationshipUrl: String = "/Relationships"
    let statisticsUrl: String = "/Statistics"
    
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
    
    func getUserByData(data: String) -> (Int, User?) {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + usersUrl, parametr: data)
        let responseCode = response.0
        let responseJson = response.1
        switch responseCode {
        case 200...299:
            return (responseCode, User(json: responseJson!))
        case 400...499:
            return (responseCode, nil)
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getUserByData, response code = \(responseCode)")
            return (0, nil)
        }
    }
    
    func addNewUser(newUser: User) -> Int {
        let responseCode = HttpRequester.sendSyncPostRequest(urlValue: baseUrl + usersUrl, dataToPost: newUser.toData())
        
        return responseCode;
    }
    
    func getUserLocation(userId: UUID) -> Location? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + locationsUrl, parametr: userId.uuidString)
        
        let responseCode = response.0
        let responseJson = response.1
        
        switch responseCode {
        case 200...299:
            return Location(json: responseJson!)
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getUserLocation, response code = \(responseCode)")
            return nil
        }
    }
    
    func updateUserLocation(newLocation: Location) -> Int {
        let responseCode = HttpRequester.sendSyncPutRequest(urlValue: baseUrl + locationsUrl, dataToPut: newLocation.toJson())
        return responseCode
    }
    
    func getUserRelationships(userId: UUID) -> [Relationship]? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + relationshipUrl, parametr: userId.uuidString)
        
        let responseCode = response.0
        let responseJson = response.1
        
        switch responseCode {
        case 200...299:
            let userRelationshipsDictionary = responseJson as! [[String : Any]]
            var userRelationships = [Relationship]()
            userRelationshipsDictionary.forEach({ relationship in
                userRelationships.append(Relationship(
                    firstUserId: UUID(uuidString:relationship["firstUserId"] as! String)!,
                    secondUserId: UUID(uuidString:relationship["secondUserId"] as! String)!,
                    statisticsID: UUID(uuidString:relationship["statisticsId"] as! String)!
                    ))
            })
            return userRelationships
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getRelationship, response code = \(responseCode)")
            return nil
        }
    }
    
    func addRelationship(newRelationship: Relationship) -> Int {
        let responseCode = HttpRequester.sendSyncPostRequest(urlValue: baseUrl + relationshipUrl, dataToPost: newRelationship.toData())
        return responseCode
    }
    
    func updateRelationship(newRelationship: Relationship) -> Int {
        let responseCode = HttpRequester.sendSyncPutRequest(urlValue: baseUrl + relationshipUrl, dataToPut: newRelationship.toJson())
        return responseCode
    }
    
    func getStatistic(statisticsId: UUID) -> Statistic? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + statisticsUrl, parametr: statisticsId.uuidString)
        
        let responseCode = response.0
        let responseJson = response.1
        
        switch responseCode {
        case 200...299:
            return Statistic(json: responseJson!)
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getStatistics, response code = \(responseCode)")
            return nil
        }
    }
    
    func addStatistic(newStatisticModel: StatisticModel) -> Int {
        let responseCode = HttpRequester.sendSyncPostRequest(urlValue: baseUrl + statisticsUrl, dataToPost: newStatisticModel.toData())
        return responseCode
    }
    
    func updateStatistic(newStatisticModel: StatisticModel) -> Int {
        let responseCode = HttpRequester.sendSyncPutRequest(urlValue: baseUrl + statisticsUrl, dataToPut: newStatisticModel.toJson())
        return responseCode
    }
    
    func getAllUserChats(userId: UUID) -> [Inbox]? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + inboxPaticipantsUrl, parametr: userId.uuidString)
        
        let responseCode = response.0
        _ = response.1
        
        switch responseCode {
        case 200...299:
            return nil
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getUserFriends, response code = \(responseCode)")
            return nil
        }
    }
}
