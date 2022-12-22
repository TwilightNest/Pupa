import Foundation
import Turf

class HttpRequester {
    
    static func sendSyncAddUserRequest(urlValue: String, jsonDictionary: [String: String]) -> Int {
        
        let url = URL(string: urlValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        let dataToPost = try! JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
        
        var responseCode = 0;
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.uploadTask(with: request, from: dataToPost) { (responseData, response, error) in
            
            responseCode = (response as? HTTPURLResponse)!.statusCode
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return responseCode
    }
    
    static func sendSyncGetUserByDataRequest(urlValue: String, dataParametr: String) -> (Int, [String : Any]) {
        
        let url = URL(string: urlValue + "/" + dataParametr)
        let request = URLRequest(url: url!)
        var responseStatusCode = 0;
        var responseJsonDictionary = [String : Any]()
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { responseData, response, error in
            
            responseStatusCode = (response as? HTTPURLResponse)!.statusCode
            
            responseJsonDictionary = try! (JSONSerialization.jsonObject(with: responseData!, options: .allowFragments) as? [String : Any])!
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return (responseStatusCode, responseJsonDictionary)
    }
    
    static func sendSyncGetUserLocationRequest(urlValue: String, userId: UUID) -> (Int, [String: Any]) {
        let url = URL(string: urlValue + "/" + userId.uuidString)
        let request = URLRequest(url: url!)
        var responseStatusCode = 0;
        var responseJsonDictionary = [String : Any]()
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { responseData, response, error in
            
            responseStatusCode = (response as? HTTPURLResponse)!.statusCode
            
            responseJsonDictionary = try! (JSONSerialization.jsonObject(with: responseData!, options: .allowFragments) as? [String : Any])!
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return (responseStatusCode, responseJsonDictionary)
    }
    
    static func sendSyncUpdateUserLocationRequest(urlValue: String, newUserLocation: UserLocation) -> Int {
        
        let url = URL(string: urlValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let dataToPut = try? JSONEncoder().encode(newUserLocation) else {
                    print("Error: Trying to convert model to JSON data")
            return 0
                }
        request.httpBody = dataToPut
        
        var responseCode = 0;
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { (responseData, response, error) in
            
            responseCode = (response as? HTTPURLResponse)!.statusCode
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return responseCode
    }
    
    static func sendSyncGetUserFriendsRequest(urlValue: String, userId: UUID) -> (Int, [String : Any]) {
        let url = URL(string: urlValue + "/" + userId.uuidString)
        let request = URLRequest(url: url!)
        var responseStatusCode = 0;
        var responseJsonDictionary = [String : Any]()
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { responseData, response, error in
            
            responseStatusCode = (response as? HTTPURLResponse)!.statusCode
            
            responseJsonDictionary = try! (JSONSerialization.jsonObject(with: responseData!, options: .allowFragments) as? [String : Any])!
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return (responseStatusCode, responseJsonDictionary)
    }
    
    static func sendSyncUpdateUserFriendsRequest(urlValue: String, newUserFriends: UserFriends) -> Int {
        
        let url = URL(string: urlValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let dataToPut = try? JSONEncoder().encode(newUserFriends) else {
                    print("Error: Trying to convert model to JSON data")
            return 0
                }
        request.httpBody = dataToPut
        
        var responseCode = 0;
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { (responseData, response, error) in
            
            responseCode = (response as? HTTPURLResponse)!.statusCode
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return responseCode
    }
}
