import Foundation

public class ApiProcessor {
    let baseUrl: String = "http://185.152.139.127"
    let usersUrl: String = "/Users"
    
    let locationsUrl: String = "/Locations"
    
    let relationshipUrl: String = "/Relationships"
    let statisticsUrl: String = "/Statistics"
    
    let chatsUrl: String = "/Chats"
    let usersChatsUrl: String = "/UsersChats"
    let messagesUrl: String = "/Messages"
    
    var currentUser: User?
    
    init(){
        updateCurrentUser()
    }
    
    func updateCurrentUser(){
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
                    userId: UUID(uuidString:relationship["userId"] as! String)!,
                    friendId: UUID(uuidString:relationship["friendId"] as! String)!,
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
    
    func addStatistic(newStatistic: Statistic) -> Int {
        let model = StatisticModel(statistic: newStatistic)
        let responseCode = HttpRequester.sendSyncPostRequest(urlValue: baseUrl + statisticsUrl, dataToPost: model.toData())
        return responseCode
    }
    
    func updateStatistic(newStatistic: Statistic) -> Int {
        let model = StatisticModel(statistic: newStatistic)
        let responseCode = HttpRequester.sendSyncPutRequest(urlValue: baseUrl + statisticsUrl, dataToPut: model.toJson())
        return responseCode
    }
    
    func getUserChats(userId: UUID) -> [Chat]? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + usersChatsUrl, parametr: "user=" + userId.uuidString)
        
        let responseCode = response.0
        let responseJson = response.1
        
        switch responseCode {
        case 200...299:
            let userChatsDictionary = responseJson as! [[String : Any]]
            var userChats = [Chat]()
            userChatsDictionary.forEach({ chat in
                userChats.append(Chat(
                    id: UUID(uuidString:chat["id"] as! String)!,
                    lastMessage: chat["lastMessage"] as! String,
                    lastSenderUserId: UUID(uuidString:chat["lastSenderUserId"] as! String)!
                    ))
            })
            return userChats
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getAllUserChats, response code = \(responseCode)")
            return nil
        }
    }
    
    func getChatUsers(chatId: UUID) -> [User]? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + usersChatsUrl, parametr: "chat=" + chatId.uuidString)
        
        let responseCode = response.0
        let responseJson = response.1
        
        switch responseCode {
        case 200...299:
            let chatUsersDictionary = responseJson as! [[String : Any]]
            var chatUsers = [User]()
            chatUsersDictionary.forEach({ user in
                chatUsers.append(User(json: user))
            })
            return chatUsers
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getAllUserChats, response code = \(responseCode)")
            return nil
        }
    }
    
    func addChat(newChatModel: ChatModel) -> Int {
        let responseCode = HttpRequester.sendSyncPostRequest(urlValue: baseUrl + chatsUrl, dataToPost: newChatModel.toData())
        return responseCode
    }
    
    func getChatMessages(chatId: UUID) -> [Message]? {
        let response = HttpRequester.sendSyncGetRequest(urlValue: baseUrl + messagesUrl, parametr: chatId.uuidString)
        
        let responseCode = response.0
        let responseJson = response.1
        
        switch responseCode {
        case 200...299:
            let chatMessagesDictionary = responseJson as! [[String : Any]]
            var chatMessages = [Message]()
            chatMessagesDictionary.forEach({ message in
                let model = MessageModel(json: message)
                chatMessages.append(Message(messageModel: model))
            })
            return chatMessages
        default:
            AlertHelper.showAlertMessage(title: "Error", message: "at getChatMessages, response code = \(responseCode)")
            return nil
        }
    }
    
    func addMessage(newMessage: Message) -> Int {
        let model = MessageModel(message: newMessage)
        let responseCode = HttpRequester.sendSyncPostRequest(urlValue: baseUrl + messagesUrl, dataToPost: model.toData())
        return responseCode
    }
}
