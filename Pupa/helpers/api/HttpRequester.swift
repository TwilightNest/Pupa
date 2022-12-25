import Foundation
import Turf

class HttpRequester {
    
    static func sendSyncGetRequest(urlValue: String, parametr: String) -> (Int, Any?){
        let url = URL(string: urlValue + "/" + parametr)
        var responseStatusCode = 0
        var responseJson: Any!
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: url!) { responseData, response, error in
            
            responseStatusCode = (response as? HTTPURLResponse)!.statusCode
            
            responseJson = try? (JSONSerialization.jsonObject(with: responseData!, options: .allowFragments))
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return (responseStatusCode, responseJson)
    }
    
    static func sendSyncPostRequest(urlValue: String, dataToPost: Data) -> Int {
        let url = URL(string: urlValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
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
    
    static func sendSyncPutRequest(urlValue: String, dataToPut: Any) -> Int {
        let url = URL(string: urlValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = (dataToPut as! Data)
        
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
